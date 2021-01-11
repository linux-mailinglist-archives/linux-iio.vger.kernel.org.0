Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316812F14A9
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jan 2021 14:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732402AbhAKN2C (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jan 2021 08:28:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731776AbhAKN2B (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jan 2021 08:28:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610371593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yPabgTJ1pydyVxoohYs10MyQog97dO8vUxkACCMc9nw=;
        b=Za28BDfJDTvFNUhfpaaS1WRt0GXNoO4EfRsviP7BiPfsiqmazfU4AOgQ/TASQL7kMGfrz1
        yoUv9qVzJSr+xKwDizW5KRPi0FoeodFFSEOsRgaN8Z5VaoTitRDEf/2QL4NP8drYt0O5Yj
        KKpXysYN+6d3nEPhHjSocjQHi9Rv5bY=
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com
 [209.85.219.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-vpUMAq6yMBeVQAdgJ5mopQ-1; Mon, 11 Jan 2021 08:26:32 -0500
X-MC-Unique: vpUMAq6yMBeVQAdgJ5mopQ-1
Received: by mail-yb1-f200.google.com with SMTP id e74so24533449ybh.19
        for <linux-iio@vger.kernel.org>; Mon, 11 Jan 2021 05:26:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPabgTJ1pydyVxoohYs10MyQog97dO8vUxkACCMc9nw=;
        b=ZD45lpkpC3b0JaeJgmYZDqXeWUccN9P+86AVNGcJEkXwRVvu1TEKEO00dJMUqj9rmW
         QHCFBW2jxoodaN59CTt9ffCvuQBYl+Cd6o4VEWqVLnPEWZLMK+mhBzILoZDGKgium/UA
         Lk7ts2/yMxIdurFY7J/acgJv8SV16T7jIsn1Srs8ctv1GMM5nT81CuINxxgwgyz6voPM
         SwkHlu30hzQvxF/4OJjgsmW9ZVjmB3bShV2eViuXYonVegjV1qnJ3DonOd2AwaULYBYe
         cRjSXEeczvygHbt+TWKBKsscE2MrE9pAqeTLlMsMIs+LxkiHDE9zNYxDDW84+al+HE8J
         /sOA==
X-Gm-Message-State: AOAM533JhzmEvz+//ROMsteAXz0I+RqSeIUFlueY1QwVjRa7PObRhL1q
        DxWa9bdN3OVXkykDoHbaMeFiSVYVumG/opM0GHFj5B8JviRqXpybM+EbPPD/yCplud6yf/5pqSF
        rXSZNiwvxeoZr6CNFbfrmA4R8mMUyuzEUw7VQ
X-Received: by 2002:a25:4905:: with SMTP id w5mr25824104yba.498.1610371591633;
        Mon, 11 Jan 2021 05:26:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3iWxJxen52ZRxGiZckpgHDRO+rraZDvro8j9fnImLlVSSHS8hx5Uyr/E2ne9/AubxStGgZgWSL5491L7/ftg=
X-Received: by 2002:a25:4905:: with SMTP id w5mr25824080yba.498.1610371591452;
 Mon, 11 Jan 2021 05:26:31 -0800 (PST)
MIME-Version: 1.0
References: <c9ec69ed349e7200c779fd7a5bf04c1aaa2817aa.1607438132.git.lorenzo@kernel.org>
 <20201213150447.119eec7c@archlinux> <CAJ0CqmXmFvEEnt_fQa+H9Lrsu9d-kj+zTWgVXakBF8z2KqEQYA@mail.gmail.com>
 <CAJ0CqmVJ9qMpLq-ZSVBFzQXSj3MNqeP5b4MjMpZh0b2H7mjXzg@mail.gmail.com>
 <20201230120850.6dd32cfc@archlinux> <20210111082134.GA2258@lore-desk> <20210111131052.000031dc@Huawei.com>
In-Reply-To: <20210111131052.000031dc@Huawei.com>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Mon, 11 Jan 2021 14:26:20 +0100
Message-ID: <CAJ0CqmWc5fQWLcZvoNvLxpa7wGc_LaP6REVKDKnkYPXReTWGZg@mail.gmail.com>
Subject: Re: [PATCH v3] iio: common: st_sensors: fix possible infinite loop in st_sensors_irq_thread
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Denis CIOCCA <denis.ciocca@st.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> On Mon, 11 Jan 2021 09:21:34 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > > On Tue, 22 Dec 2020 11:53:57 +0100
> > > Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:
> > >
> > > > >
> >
> > [...]
> >
> > > It's a very minor gamble, so I've applied it to the fixes-togreg branch of
> > > iio.git.  Fingers crossed no one hits the corner case and has somehow been
> > > getting away with it.
> > >
> > > Thanks,
> >
> > Hi Jonathan,
> >
> > I am not able to find this commit in your tree. Am I missing something?
>
> oops. Now pushed out.

ack, thx :)

Regards,
Lorenzo

>
> J
>
> >
> > Regards,
> > Lorenzo
> >
> > >
> > > Jonathan
> > >
> > > >
> > > > > Regards,
> > > > > Lorenzo
> > > > >
> > > > > >
> > > > > > It's possible we would be better falling back to interrupt free support
> > > > > > in that case rather than failing to probe at all.
> > > > > > I think that would be best done by moving the check out to the
> > > > > > various per type drivers so we fail in the same fashion as no irq
> > > > > > provided + a warning.
> > > > >
> > > > >
> > > > > >
> > > > > > thanks,
> > > > > >
> > > > > > Jonathan
> > > > > >
> > > > > >
> > > > > > > ---
> > > > > > > Changes since v2:
> > > > > > > - return -EOPNOTSUPP if the drv requests edge IRQ and the sensor does not support
> > > > > > >   status register
> > > > > > >
> > > > > > > Changes since v1:
> > > > > > > - return true if the sensor does not have stat_drdy register
> > > > > > > ---
> > > > > > >  .../common/st_sensors/st_sensors_trigger.c    | 31 ++++++++++---------
> > > > > > >  1 file changed, 17 insertions(+), 14 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > > > > > index 0507283bd4c1..2dbd2646e44e 100644
> > > > > > > --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > > > > > +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > > > > > > @@ -23,35 +23,31 @@
> > > > > > >   * @sdata: Sensor data.
> > > > > > >   *
> > > > > > >   * returns:
> > > > > > > - * 0 - no new samples available
> > > > > > > - * 1 - new samples available
> > > > > > > - * negative - error or unknown
> > > > > > > + * false - no new samples available or read error
> > > > > > > + * true - new samples available
> > > > > > >   */
> > > > > > > -static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
> > > > > > > -                                         struct st_sensor_data *sdata)
> > > > > > > +static bool st_sensors_new_samples_available(struct iio_dev *indio_dev,
> > > > > > > +                                          struct st_sensor_data *sdata)
> > > > > > >  {
> > > > > > >       int ret, status;
> > > > > > >
> > > > > > >       /* How would I know if I can't check it? */
> > > > > > >       if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
> > > > > > > -             return -EINVAL;
> > > > > > > +             return true;
> > > > > > >
> > > > > > >       /* No scan mask, no interrupt */
> > > > > > >       if (!indio_dev->active_scan_mask)
> > > > > > > -             return 0;
> > > > > > > +             return false;
> > > > > > >
> > > > > > >       ret = regmap_read(sdata->regmap,
> > > > > > >                         sdata->sensor_settings->drdy_irq.stat_drdy.addr,
> > > > > > >                         &status);
> > > > > > >       if (ret < 0) {
> > > > > > >               dev_err(sdata->dev, "error checking samples available\n");
> > > > > > > -             return ret;
> > > > > > > +             return false;
> > > > > > >       }
> > > > > > >
> > > > > > > -     if (status & sdata->sensor_settings->drdy_irq.stat_drdy.mask)
> > > > > > > -             return 1;
> > > > > > > -
> > > > > > > -     return 0;
> > > > > > > +     return !!(status & sdata->sensor_settings->drdy_irq.stat_drdy.mask);
> > > > > >
> > > > > > No need for the !! as you can rely on type conversion to a boolean.
> > > > > >
> > > > > > >  }
> > > > > > >
> > > > > > >  /**
> > > > > > > @@ -180,9 +176,15 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
> > > > > > >
> > > > > > >       /* Tell the interrupt handler that we're dealing with edges */
> > > > > > >       if (irq_trig == IRQF_TRIGGER_FALLING ||
> > > > > > > -         irq_trig == IRQF_TRIGGER_RISING)
> > > > > > > +         irq_trig == IRQF_TRIGGER_RISING) {
> > > > > > > +             if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr) {
> > > > > > > +                     dev_err(&indio_dev->dev,
> > > > > > > +                             "edge IRQ not supported w/o stat register.\n");
> > > > > > > +                     err = -EOPNOTSUPP;
> > > > > > > +                     goto iio_trigger_free;
> > > > > > > +             }
> > > > > > >               sdata->edge_irq = true;
> > > > > > > -     else
> > > > > > > +     } else {
> > > > > > >               /*
> > > > > > >                * If we're not using edges (i.e. level interrupts) we
> > > > > > >                * just mask off the IRQ, handle one interrupt, then
> > > > > > > @@ -190,6 +192,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
> > > > > > >                * interrupt handler top half again and start over.
> > > > > > >                */
> > > > > > >               irq_trig |= IRQF_ONESHOT;
> > > > > > > +     }
> > > > > > >
> > > > > > >       /*
> > > > > > >        * If the interrupt pin is Open Drain, by definition this
> > > > > >
> > > >
> > >
> >
>

