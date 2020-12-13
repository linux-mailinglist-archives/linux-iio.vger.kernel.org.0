Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47AA82D9010
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 20:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389113AbgLMTYn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 14:24:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31511 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2395430AbgLMTYY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 13 Dec 2020 14:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607887377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UCUFH1g6R5hlg0/ShGsmD8TWZ1YfST5jbAOjsQ7Cmc8=;
        b=DrhyNCa9kW5B5MF7Moqzr43eIPR8vHTnm093bLMrdv11TxXEzgMPmZa+4msoZt1AbHp2nZ
        PQKa/FAEGXfqCz6cts6BtCskQfsaL4xi5SzGq0zxTa2Ekpy8qEG0E9m2cVyDTaqYxXm9bC
        MRkXCvQVFdzWTi8/1hIQ7gJ3jFgxES8=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-5q6PNBPZNle88qX8KYCFjw-1; Sun, 13 Dec 2020 14:22:51 -0500
X-MC-Unique: 5q6PNBPZNle88qX8KYCFjw-1
Received: by mail-yb1-f198.google.com with SMTP id h75so18249572ybg.18
        for <linux-iio@vger.kernel.org>; Sun, 13 Dec 2020 11:22:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCUFH1g6R5hlg0/ShGsmD8TWZ1YfST5jbAOjsQ7Cmc8=;
        b=WMZxCWAKpjVxDuRCCZ2n4cfGZyAdjLjq64mzJ2Z219NOqGRI8eckuuxZ8mcigT+DXY
         xuf2/C8GshOcfq2xTEB4EVwl2a+xpPNU8R60Y2TsAD28g7PvxaAmTqL24JHdzSd+ganI
         VfguuhIMMC4nmk6ux9xP9gnbSI7QfnajYvH29CJg2mgcrhyZK5tMGvcYuJuw77lnhumX
         Yq0PmFRBWDhsXYWtoc4yK7zEIe8GomjvlC0SlqNtauUYK9CTj8Zhj4aB8JceVSmuwkdo
         7HD4PmOWFsTSJDcViXzYZpYBxdoekmxaSUWqKlxbVixfEA/S7ynnbPaNPJMxM/zzcP+P
         mTNQ==
X-Gm-Message-State: AOAM5333XvekimG+82iykjYmcVuV97852FBnKon1XYGVHPiT9MhiPNJh
        rTv4kMhcJQEjiwds6/Z3rQ8E3P4mszkgGcP+iDgXGVyIVchJosulAfUfrB6v89h7fSearcPGxWE
        ZwR2UsWHWsvYYGkG4B5TZjGb6Kp3ksI2hDtmD
X-Received: by 2002:a25:5f52:: with SMTP id h18mr20056688ybm.285.1607887371136;
        Sun, 13 Dec 2020 11:22:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwiEQGVMA7KZK5Oe05kOoRTpwMtS0loa8nZzNbEVlcXTTSf21uaJLQ9LrKug6RU9HyMOX4nW2W7nM1yn8EM32E=
X-Received: by 2002:a25:5f52:: with SMTP id h18mr20056669ybm.285.1607887370837;
 Sun, 13 Dec 2020 11:22:50 -0800 (PST)
MIME-Version: 1.0
References: <c9ec69ed349e7200c779fd7a5bf04c1aaa2817aa.1607438132.git.lorenzo@kernel.org>
 <20201213150447.119eec7c@archlinux>
In-Reply-To: <20201213150447.119eec7c@archlinux>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Sun, 13 Dec 2020 20:23:35 +0100
Message-ID: <CAJ0CqmXmFvEEnt_fQa+H9Lrsu9d-kj+zTWgVXakBF8z2KqEQYA@mail.gmail.com>
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
> On Tue,  8 Dec 2020 15:36:40 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>
> > Return a boolean value in st_sensors_new_samples_available routine in
> > order to avoid an infinite loop in st_sensors_irq_thread if
> > stat_drdy.addr is not defined or stat_drdy read fails
> >
> > Fixes: 90efe05562921 ("iio: st_sensors: harden interrupt handling")
> > Reported-by: Jonathan Cameron <jic23@kernel.org>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>
> One trivial inline. Note I'm looking for an Ack form Dennis on this one
> as it may result in a some breakage if any devices are using
> edge interrupts.

Looking at the current code I am wondering if it is possible since we
would have already triggered the infinite loop in this case. I think
nobody is currently using edge interrupts if the status register is
not available. What do you think?

Regards,
Lorenzo

>
> It's possible we would be better falling back to interrupt free support
> in that case rather than failing to probe at all.
> I think that would be best done by moving the check out to the
> various per type drivers so we fail in the same fashion as no irq
> provided + a warning.


>
> thanks,
>
> Jonathan
>
>
> > ---
> > Changes since v2:
> > - return -EOPNOTSUPP if the drv requests edge IRQ and the sensor does not support
> >   status register
> >
> > Changes since v1:
> > - return true if the sensor does not have stat_drdy register
> > ---
> >  .../common/st_sensors/st_sensors_trigger.c    | 31 ++++++++++---------
> >  1 file changed, 17 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/iio/common/st_sensors/st_sensors_trigger.c b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > index 0507283bd4c1..2dbd2646e44e 100644
> > --- a/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > +++ b/drivers/iio/common/st_sensors/st_sensors_trigger.c
> > @@ -23,35 +23,31 @@
> >   * @sdata: Sensor data.
> >   *
> >   * returns:
> > - * 0 - no new samples available
> > - * 1 - new samples available
> > - * negative - error or unknown
> > + * false - no new samples available or read error
> > + * true - new samples available
> >   */
> > -static int st_sensors_new_samples_available(struct iio_dev *indio_dev,
> > -                                         struct st_sensor_data *sdata)
> > +static bool st_sensors_new_samples_available(struct iio_dev *indio_dev,
> > +                                          struct st_sensor_data *sdata)
> >  {
> >       int ret, status;
> >
> >       /* How would I know if I can't check it? */
> >       if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr)
> > -             return -EINVAL;
> > +             return true;
> >
> >       /* No scan mask, no interrupt */
> >       if (!indio_dev->active_scan_mask)
> > -             return 0;
> > +             return false;
> >
> >       ret = regmap_read(sdata->regmap,
> >                         sdata->sensor_settings->drdy_irq.stat_drdy.addr,
> >                         &status);
> >       if (ret < 0) {
> >               dev_err(sdata->dev, "error checking samples available\n");
> > -             return ret;
> > +             return false;
> >       }
> >
> > -     if (status & sdata->sensor_settings->drdy_irq.stat_drdy.mask)
> > -             return 1;
> > -
> > -     return 0;
> > +     return !!(status & sdata->sensor_settings->drdy_irq.stat_drdy.mask);
>
> No need for the !! as you can rely on type conversion to a boolean.
>
> >  }
> >
> >  /**
> > @@ -180,9 +176,15 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
> >
> >       /* Tell the interrupt handler that we're dealing with edges */
> >       if (irq_trig == IRQF_TRIGGER_FALLING ||
> > -         irq_trig == IRQF_TRIGGER_RISING)
> > +         irq_trig == IRQF_TRIGGER_RISING) {
> > +             if (!sdata->sensor_settings->drdy_irq.stat_drdy.addr) {
> > +                     dev_err(&indio_dev->dev,
> > +                             "edge IRQ not supported w/o stat register.\n");
> > +                     err = -EOPNOTSUPP;
> > +                     goto iio_trigger_free;
> > +             }
> >               sdata->edge_irq = true;
> > -     else
> > +     } else {
> >               /*
> >                * If we're not using edges (i.e. level interrupts) we
> >                * just mask off the IRQ, handle one interrupt, then
> > @@ -190,6 +192,7 @@ int st_sensors_allocate_trigger(struct iio_dev *indio_dev,
> >                * interrupt handler top half again and start over.
> >                */
> >               irq_trig |= IRQF_ONESHOT;
> > +     }
> >
> >       /*
> >        * If the interrupt pin is Open Drain, by definition this
>

