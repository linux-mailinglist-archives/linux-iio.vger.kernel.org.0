Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CED91E64E8
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2019 19:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfJ0Sh7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 14:37:59 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:46706 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727357AbfJ0Sh6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Oct 2019 14:37:58 -0400
Received: by mail-io1-f66.google.com with SMTP id c6so7932649ioo.13
        for <linux-iio@vger.kernel.org>; Sun, 27 Oct 2019 11:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W72JgsGPmmhNZtme6eDZdINe8MmHqALahwfmKP4ShyY=;
        b=nGexxOxcZS1qZt7/3zp5kR38mDu+QZrlelR9kgOjdQDmyEqBCURDadNT0ztc9FQwsx
         LKgMULOyAqSQ45pZs+UkKaPOnHYa0/TZeyAUa9q9UBSVZmmSu9uSEHPbM+/zMziMnmv5
         Itoqh8yZLC0RBddUhglUSMdq17Fujs22/FMuc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W72JgsGPmmhNZtme6eDZdINe8MmHqALahwfmKP4ShyY=;
        b=Du3yJTxlD0q7VBDALC1uKaouaJ9nl6aJZyYXiNbprVZKvLoDMlmvgqEQcmTBFdqpk4
         ZV14u8EPFOxCFsgSbBCaU5KUKdoL9xZSbFDi9x1W3r57eP1Ps/f98KX1hx+Yc65vV0+h
         Jz8NUaGmWEKV9z3r6982XPj83/rTbMhWm0uxSrO6qwJ2FkZyOjiMkY1NwG3r4VywRLQv
         OV7/QcybASa+Iv9i4WoeW3di8hoIClqPUBgD3zPzU9e9U8HZ7zo/EF2gQYN622DnUWfE
         rIlugeEcPsF3SX5KaIGYGfq1QQ1/yC1+rucqFtafuKt1c+9cPbuWIr++a0gUVICAkDri
         zyxg==
X-Gm-Message-State: APjAAAVD17klhutDrr0tJTrJ/FPaOayyQUO70FkKIj7poaVDztRlmyLh
        +4QBs2Gs5WFn7qIhN1CcbsMwB6b4IeiWm/yY63f5kCMwUyw77g==
X-Google-Smtp-Source: APXvYqx1UK50ahGkEjebYFM9F1IbeNRlx0P4sN3kHyF3iD58GLyRWSqSX2jSzVpEO3cegs1acO6aGNHshVbwoLYjd2E=
X-Received: by 2002:a6b:c305:: with SMTP id t5mr13106457iof.87.1572201476275;
 Sun, 27 Oct 2019 11:37:56 -0700 (PDT)
MIME-Version: 1.0
References: <20191023082714.18681-1-alexandru.ardelean@analog.com> <20191027165813.5a5b0519@archlinux>
In-Reply-To: <20191027165813.5a5b0519@archlinux>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 27 Oct 2019 20:37:45 +0200
Message-ID: <CAJCx=gnCaqKHuZkRoCyHXR4ewwmqFCsRTiUty=CH0KB8PS+YCQ@mail.gmail.com>
Subject: Re: [PATCH] iio: hdc100x: fix iio_triggered_buffer_{predisable,postenable}
 positions
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 27, 2019 at 6:58 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 23 Oct 2019 11:27:14 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > The iio_triggered_buffer_postenable() hook should be called first to
> > attach the poll function and the iio_triggered_buffer_predisable() hook
> > should be called last in the predisable hook.
> >
> > This change updates the driver to attach/detach the poll func in the
> > correct order.
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Seems fine, but should have cc'd Matt and I'd like to give him time
> to take a quick look.
>

Reviewed-by: Matt Ranostay <matt.ranostay@konsulko.com>

> +CC Matt.
>
> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/humidity/hdc100x.c | 19 +++++++++++--------
> >  1 file changed, 11 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/iio/humidity/hdc100x.c b/drivers/iio/humidity/hdc100x.c
> > index bfe1cdb16846..963ff043eecf 100644
> > --- a/drivers/iio/humidity/hdc100x.c
> > +++ b/drivers/iio/humidity/hdc100x.c
> > @@ -278,31 +278,34 @@ static int hdc100x_buffer_postenable(struct iio_dev *indio_dev)
> >       struct hdc100x_data *data = iio_priv(indio_dev);
> >       int ret;
> >
> > +     ret = iio_triggered_buffer_postenable(indio_dev);
> > +     if (ret)
> > +             return ret;
> > +
> >       /* Buffer is enabled. First set ACQ Mode, then attach poll func */
> >       mutex_lock(&data->lock);
> >       ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE,
> >                                   HDC100X_REG_CONFIG_ACQ_MODE);
> >       mutex_unlock(&data->lock);
> >       if (ret)
> > -             return ret;
> > +             iio_triggered_buffer_predisable(indio_dev);
> >
> > -     return iio_triggered_buffer_postenable(indio_dev);
> > +     return ret;
> >  }
> >
> >  static int hdc100x_buffer_predisable(struct iio_dev *indio_dev)
> >  {
> >       struct hdc100x_data *data = iio_priv(indio_dev);
> > -     int ret;
> > -
> > -     /* First detach poll func, then reset ACQ mode. OK to disable buffer */
> > -     ret = iio_triggered_buffer_predisable(indio_dev);
> > -     if (ret)
> > -             return ret;
> > +     int ret, ret2;
> >
> >       mutex_lock(&data->lock);
> >       ret = hdc100x_update_config(data, HDC100X_REG_CONFIG_ACQ_MODE, 0);
> >       mutex_unlock(&data->lock);
> >
> > +     ret2 = iio_triggered_buffer_predisable(indio_dev);
> > +     if (ret == 0)
> > +             ret = ret2;
> > +
> >       return ret;
> >  }
> >
>
