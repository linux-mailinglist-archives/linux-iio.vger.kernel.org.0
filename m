Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB782E0904
	for <lists+linux-iio@lfdr.de>; Tue, 22 Dec 2020 11:55:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgLVKzi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Dec 2020 05:55:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32604 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726108AbgLVKzi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Dec 2020 05:55:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608634451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/IEfXU6bCrQ3sMal0t1ThDjcroCrSJSjVmznq5sFKX8=;
        b=a6JzpKWU36JZ30C619VkjTIxvmuIAF/le/78Rv7Wk+K0PVOOrHfr5eRDQVbvtwr7xoUU47
        TMTs4z4qtbWlLl7wFjzh1Or9iXp14KAlnNCOScC/P4hyNNjXneYkV0+lN8dtjnkJLEoMF2
        TFz+v2+O1OVagkinUg7EkLh8LufNTEc=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-6jogMdARMR-nZS04L2JLeg-1; Tue, 22 Dec 2020 05:54:08 -0500
X-MC-Unique: 6jogMdARMR-nZS04L2JLeg-1
Received: by mail-yb1-f200.google.com with SMTP id m203so17384362ybf.1
        for <linux-iio@vger.kernel.org>; Tue, 22 Dec 2020 02:54:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/IEfXU6bCrQ3sMal0t1ThDjcroCrSJSjVmznq5sFKX8=;
        b=FY5gkFFJzXA/F3thliObV5gvOJS/nNAk1ip5qzc+cyldoKDGjX1rC/McEI0qklRoyZ
         ErAMEhUQko3+NkecfrqiA9MB/ArWiIi2JFBYic51YjS6EQNi0VU0stzJ9LqqaF/OB/JY
         ysXYQOaWyCu3us7RyVXEx4sliy+aU2SwnwvwJ+HeIc+fsRF9hNagR8jsHemkKrScPiM1
         gABQT483oTcxvRAsvKyXVmv8vNunWunHSXRk2+umCrpA7tN8bIu6nrTQbodWgN4NS+Rx
         4m8jPVhaAeP/L4dNZTPsTaxRDkCiQUClPOrZaq4SGp/fxC4btnY6tb82pIEzR0DtG+Zs
         SQOQ==
X-Gm-Message-State: AOAM531iv8VQEBac+e4PQ9MmTIFY4gu+L31ygehmETJ4D2sXhVWDxmwh
        AVR1vl+hmcEKh6dSrJY63CjTMK+BtPsSmCQ+cYwPipLV8mHN2TpraM0+/ztyw+LQp6y6bfCEhwG
        kuIn5INJREBh9bhet4kcquJ+vFdBwtTv2SUES
X-Received: by 2002:a25:9c83:: with SMTP id y3mr26012386ybo.307.1608634448185;
        Tue, 22 Dec 2020 02:54:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxzamkZL021j0uWW0iTKqFq84zjtAqITxw7D8q6X+kN9xol8t40LgFhq3LGdAfC7C/NxMtt7qQHgnulNHH7eRU=
X-Received: by 2002:a25:9c83:: with SMTP id y3mr26012362ybo.307.1608634447920;
 Tue, 22 Dec 2020 02:54:07 -0800 (PST)
MIME-Version: 1.0
References: <c9ec69ed349e7200c779fd7a5bf04c1aaa2817aa.1607438132.git.lorenzo@kernel.org>
 <20201213150447.119eec7c@archlinux> <CAJ0CqmXmFvEEnt_fQa+H9Lrsu9d-kj+zTWgVXakBF8z2KqEQYA@mail.gmail.com>
In-Reply-To: <CAJ0CqmXmFvEEnt_fQa+H9Lrsu9d-kj+zTWgVXakBF8z2KqEQYA@mail.gmail.com>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Tue, 22 Dec 2020 11:53:57 +0100
Message-ID: <CAJ0CqmVJ9qMpLq-ZSVBFzQXSj3MNqeP5b4MjMpZh0b2H7mjXzg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: common: st_sensors: fix possible infinite loop in st_sensors_irq_thread
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Denis CIOCCA <denis.ciocca@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> >
> > On Tue,  8 Dec 2020 15:36:40 +0100
> > Lorenzo Bianconi <lorenzo@kernel.org> wrote:
> >
> > > Return a boolean value in st_sensors_new_samples_available routine in
> > > order to avoid an infinite loop in st_sensors_irq_thread if
> > > stat_drdy.addr is not defined or stat_drdy read fails
> > >
> > > Fixes: 90efe05562921 ("iio: st_sensors: harden interrupt handling")
> > > Reported-by: Jonathan Cameron <jic23@kernel.org>
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> >
> > One trivial inline. Note I'm looking for an Ack form Dennis on this one
> > as it may result in a some breakage if any devices are using
> > edge interrupts.
>
> Looking at the current code I am wondering if it is possible since we
> would have already triggered the infinite loop in this case. I think
> nobody is currently using edge interrupts if the status register is
> not available. What do you think?
>

Hi Jonathan,

any news about this patch?

Regards,
Lorenzo

> Regards,
> Lorenzo
>
> >
> > It's possible we would be better falling back to interrupt free support
> > in that case rather than failing to probe at all.
> > I think that would be best done by moving the check out to the
> > various per type drivers so we fail in the same fashion as no irq
> > provided + a warning.
>
>
> >
> > thanks,
> >
> > Jonathan
> >
> >
> > > ---
> > > Changes since v2:
> > > - return -EOPNOTSUPP if the drv requests edge IRQ and the sensor does not support
> > >   status register
> > >
> > > Changes since v1:
> > > - return true if the sensor does not have stat_drdy register
> > > ---
> > >  .../common/st_sensors/st_sensors_trigger.c    | 31 ++++++++++---------
> > >  1 file changed, 17 insertions(+), 14 deletions(-)
> > >
> > > diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > index 0507283bd4c1..2dbd2646e44e 100644
> > > --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > @@ -23,35 +23,31 @@
> > >   * @sdata: Sensor data.
> > >   *
> > >   * returns:
> > > - * 0 - no new samples available
> > > - * 1 - new samples available
> > > - * negative - error or unknown
> > > + * false - no new samples available or read error
> > > + * true - new samples available
> > >   */
> > > -static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
> > > -                                         struct st_sensor_data *sdata)
> > > +static bool st_sensors_new_samples_available(struct iio_dev *indio_dev,
> > > +                                          struct st_sensor_data *sdata)
> > >  {
> > >       int ret, status;
> > >
> > >       /* How would I know if I can't check it? */
> > >       if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
> > > -             return -EINVAL;
> > > +             return true;
> > >
> > >       /* No scan mask, no interrupt */
> > >       if (!indio_dev->active_scan_mask)
> > > -             return 0;
> > > +             return false;
> > >
> > >       ret = regmap_read(sdata->regmap,
> > >                         sdata->sensor_settings->drdy_irq.stat_drdy.addr,
> > >                         &status);
> > >       if (ret < 0) {
> > >               dev_err(sdata->dev, "error checking samples available\n");
> > > -             return ret;
> > > +             return false;
> > >       }
> > >
> > > -     if (status & sdata->sensor_settings->drdy_irq.stat_drdy.mask)
> > > -             return 1;
> > > -
> > > -     return 0;
> > > +     return !!(status & sdata->sensor_settings->drdy_irq.stat_drdy.mask);
> >
> > No need for the !! as you can rely on type conversion to a boolean.
> >
> > >  }
> > >
> > >  /**
> > > @@ -180,9 +176,15 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
> > >
> > >       /* Tell the interrupt handler that we're dealing with edges */
> > >       if (irq_trig == IRQF_TRIGGER_FALLING ||
> > > -         irq_trig == IRQF_TRIGGER_RISING)
> > > +         irq_trig == IRQF_TRIGGER_RISING) {
> > > +             if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr) {
> > > +                     dev_err(&indio_dev->dev,
> > > +                             "edge IRQ not supported w/o stat register.\n");
> > > +                     err = -EOPNOTSUPP;
> > > +                     goto iio_trigger_free;
> > > +             }
> > >               sdata->edge_irq = true;
> > > -     else
> > > +     } else {
> > >               /*
> > >                * If we're not using edges (i.e. level interrupts) we
> > >                * just mask off the IRQ, handle one interrupt, then
> > > @@ -190,6 +192,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
> > >                * interrupt handler top half again and start over.
> > >                */
> > >               irq_trig |= IRQF_ONESHOT;
> > > +     }
> > >
> > >       /*
> > >        * If the interrupt pin is Open Drain, by definition this
> >

