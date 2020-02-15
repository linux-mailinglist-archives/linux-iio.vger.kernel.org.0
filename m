Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA1AF1600F4
	for <lists+linux-iio@lfdr.de>; Sat, 15 Feb 2020 23:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726275AbgBOWn4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Feb 2020 17:43:56 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:45597 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgBOWnz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Feb 2020 17:43:55 -0500
Received: by mail-il1-f193.google.com with SMTP id p8so11141587iln.12
        for <linux-iio@vger.kernel.org>; Sat, 15 Feb 2020 14:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vv96zpKyFBx2QC1IPRXr1O8XgKuM0hJ/alyw6ceTJIw=;
        b=BR4A2tAvLDITAP9w9iBGxeYiFJ6tuexDjn/OQhwmDWA4TgcuBcuY/YkvSJCrTPNTEW
         pZb0cgx92/wFe2skUYYyOVOJX3eCPj6Mrun9vAFqpiz4m4A4C7IewFveU9SHa9BoyBn5
         F2mizVNrK7gjXxsm12XfuL4ygQYVijGnv9FD0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vv96zpKyFBx2QC1IPRXr1O8XgKuM0hJ/alyw6ceTJIw=;
        b=HEl6OMi7ArHbJnh6aGMQdpP4BsdxF9K2vEKWK7LTRNWkPHNPXGVSaef1va+vkt7iBM
         eI4D6oIgaRYM7onscDxD1IohniH7P1RxIyAlo/pVaPuHQgvEzsDphdCtxpHn8w5eNQJA
         /algZFUJxE3IufhqdBwb3fKg8qVPUCUGohE5R0MQna5nx09Yv4jeO6c7xa2CmC4o+NVD
         RNBf2vrbK6gBO/M+H8z1GGzEueSz10JnKzwop/L8n2/H7Yv1pbdmwy+ElgP1KouVneMS
         vwSZF8I2yEM0NWeLCtKi4AGnYO1iwCWv2rpmgQvmKdym6UrQaOCH6ldK3ySPrVcHVYNJ
         y2lQ==
X-Gm-Message-State: APjAAAUTV0SIXokrj81KbOzPURtF0dZT3UXjy/zrAHlduWmr+hF9MwnE
        W6QAnHvi3TIfz1Ja4PslePYa7mvQudz14F9M472njhx7sWwbqg==
X-Google-Smtp-Source: APXvYqxatHHB6eM2r5Vr4esO8FTFUrnNk0RQmXy4fojZlPMRkPG2c0soZlrfooyL6mZOk6XxyPssNYagUGR4ahc/vcw=
X-Received: by 2002:a92:216:: with SMTP id 22mr8672320ilc.53.1581806633597;
 Sat, 15 Feb 2020 14:43:53 -0800 (PST)
MIME-Version: 1.0
References: <20200210001058.7515-1-matt.ranostay@konsulko.com>
 <20200210001058.7515-2-matt.ranostay@konsulko.com> <20200214142425.431548cf@archlinux>
In-Reply-To: <20200214142425.431548cf@archlinux>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sat, 15 Feb 2020 14:43:43 -0800
Message-ID: <CAJCx=gm6XHfnCF70PgBu4MQHYw0WoB3y4egQa_1NUunr-MfNSw@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] iio: chemical: atlas-sensor: allow probe without
 interrupt line
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Feb 14, 2020 at 6:24 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sun,  9 Feb 2020 16:10:56 -0800
> Matt Ranostay <matt.ranostay@konsulko.com> wrote:
>
> > Sensors don't actually need a interrupt line to give valid readings,
> > and can triggered with CONFIG_IIO_HRTIMER_TRIGGER as well. Remove
> > the required check for interrupt, and continue along in the probe
> > function.
> >
> > Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
>
> Hi Matt,
>
> I'm going to hold this for conclusion of the discussion about whether
> the interrupt enable / disable should be related to the buffer or the trigger.
> (v4 I think...)
>

Ah yes reading that thread now and think I understand what needs to be changed.
However the rest of the series can be merged on its own without any issues.

- Matt

> Thanks,
>
> Jonathan
>
> > ---
> >  drivers/iio/chemical/atlas-sensor.c | 27 ++++++++++++---------------
> >  1 file changed, 12 insertions(+), 15 deletions(-)
> >
> > diff --git a/drivers/iio/chemical/atlas-sensor.c b/drivers/iio/chemical/atlas-sensor.c
> > index 2f0a6fed2589..9a1ab9f8fcc5 100644
> > --- a/drivers/iio/chemical/atlas-sensor.c
> > +++ b/drivers/iio/chemical/atlas-sensor.c
> > @@ -572,11 +572,6 @@ static int atlas_probe(struct i2c_client *client,
> >       if (ret)
> >               return ret;
> >
> > -     if (client->irq <= 0) {
> > -             dev_err(&client->dev, "no valid irq defined\n");
> > -             return -EINVAL;
> > -     }
> > -
> >       ret = chip->calibration(data);
> >       if (ret)
> >               return ret;
> > @@ -596,16 +591,18 @@ static int atlas_probe(struct i2c_client *client,
> >
> >       init_irq_work(&data->work, atlas_work_handler);
> >
> > -     /* interrupt pin toggles on new conversion */
> > -     ret = devm_request_threaded_irq(&client->dev, client->irq,
> > -                                     NULL, atlas_interrupt_handler,
> > -                                     IRQF_TRIGGER_RISING |
> > -                                     IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > -                                     "atlas_irq",
> > -                                     indio_dev);
> > -     if (ret) {
> > -             dev_err(&client->dev, "request irq (%d) failed\n", client->irq);
> > -             goto unregister_buffer;
> > +     if (client->irq > 0) {
> > +             /* interrupt pin toggles on new conversion */
> > +             ret = devm_request_threaded_irq(&client->dev, client->irq,
> > +                             NULL, atlas_interrupt_handler,
> > +                             IRQF_TRIGGER_RISING |
> > +                             IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > +                             "atlas_irq",
> > +                             indio_dev);
> > +
> > +             if (ret)
> > +                     dev_warn(&client->dev,
> > +                             "request irq (%d) failed\n", client->irq);
> >       }
> >
> >       ret = atlas_set_powermode(data, 1);
>
