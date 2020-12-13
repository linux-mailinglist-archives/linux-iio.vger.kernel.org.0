Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A09B62D8E00
	for <lists+linux-iio@lfdr.de>; Sun, 13 Dec 2020 15:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgLMOgb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Dec 2020 09:36:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:44596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbgLMOgb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Dec 2020 09:36:31 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 46725230FB;
        Sun, 13 Dec 2020 14:35:49 +0000 (UTC)
Date:   Sun, 13 Dec 2020 14:35:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] iio: acpi_als: Add trigger support
Message-ID: <20201213143546.1c1d834f@archlinux>
In-Reply-To: <CAPUE2utiv5-MPx9LHTn0SLTLGcFgVE2YzNS1U3HhZy0W3F+-jw@mail.gmail.com>
References: <20201204203755.818932-1-gwendal@chromium.org>
        <20201205182659.7cd23d5b@archlinux>
        <CAPUE2utiv5-MPx9LHTn0SLTLGcFgVE2YzNS1U3HhZy0W3F+-jw@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

...

> >  
> > >  };
> > > @@ -104,33 +108,20 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
> > >  {
> > >       struct iio_dev *indio_dev = acpi_driver_data(device);
> > >       struct acpi_als *als = iio_priv(indio_dev);
> > > -     s32 *buffer = als->evt_buffer;
> > > -     s64 time_ns = iio_get_time_ns(indio_dev);
> > > -     s32 val;
> > > -     int ret;
> > > -
> > > -     mutex_lock(&als->lock);
> > >
> > > -     memset(buffer, 0, ACPI_ALS_EVT_BUFFER_SIZE);
> > > +     if (!iio_buffer_enabled(indio_dev) ||
> > > +         !iio_trigger_using_own(indio_dev))
> > > +             return;
> > >
> > >       switch (event) {
> > >       case ACPI_ALS_NOTIFY_ILLUMINANCE:
> > > -             ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
> > > -             if (ret < 0)
> > > -                     goto out;
> > > -             *buffer++ = val;
> > > +             iio_trigger_poll_chained(als->trig);  
> >
> > One issue with this path is it won't have set the poll function timestamp.
> > It's a long term problem that there is no way for a device to know with
> > certainty if the top half of it's trigger handler was ever called.
> >
> > I have been thinking about adding accessors to pf->timestamp to set
> > and clear it which could also set a flag to say it had been set.
> > Hence the get would return an error if not and we could grab a local
> > timestamp if that happens as it would be the best available.  
> Looking at other devices that support sw/hw riggers (for instance
> light/rpr0521.c), pf->timestamp == 0 indicates that the top half was
> not called.

While it should be vanishingly rare, in theory timestamp == 0 is
a valid time.  I agree in practice we could use that but I would
prefer clearer semantics / code readability as would occur with
explicit accessors.

> >
> > Anyhow, I would assume you will get all 0 timestamps currently.
> >  
> > >               break;
> > >       default:
> > >               /* Unhandled event */
> > >               dev_dbg(&device->dev, "Unhandled ACPI ALS event (%08x)!\n",
> > >                       event);
> > > -             goto out;
> > >       }
> > > -
> > > -     iio_push_to_buffers_with_timestamp(indio_dev, als->evt_buffer, time_ns);
> > > -
> > > -out:
> > > -     mutex_unlock(&als->lock);
> > >  }
> > >
> > >  static int acpi_als_read_raw(struct iio_dev *indio_dev,
> > > @@ -161,11 +152,37 @@ static const struct iio_info acpi_als_info = {
> > >       .read_raw               = acpi_als_read_raw,
> > >  };
...

> > >  static int acpi_als_add(struct acpi_device *device)
> > >  {
> > >       struct acpi_als *als;
> > >       struct iio_dev *indio_dev;
> > > -     struct iio_buffer *buffer;
> > > +     int ret;
> > >
> > >       indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
> > >       if (!indio_dev)
> > > @@ -180,15 +197,30 @@ static int acpi_als_add(struct acpi_device *device)
> > >       indio_dev->name = ACPI_ALS_DEVICE_NAME;
> > >       indio_dev->dev.parent = &device->dev;
> > >       indio_dev->info = &acpi_als_info;
> > > -     indio_dev->modes = INDIO_BUFFER_SOFTWARE;
> > > +     indio_dev->modes = INDIO_DIRECT_MODE;
> > >       indio_dev->channels = acpi_als_channels;
> > >       indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
> > >
> > > -     buffer = devm_iio_kfifo_allocate(&device->dev);
> > > -     if (!buffer)
> > > +     als->trig = devm_iio_trigger_alloc(&device->dev,
> > > +                                        "%s-dev%d",
> > > +                                        indio_dev->name,
> > > +                                        indio_dev->id);
> > > +     if (!als->trig)
> > >               return -ENOMEM;
> > >
> > > -     iio_device_attach_buffer(indio_dev, buffer);
> > > +     als->trig->dev.parent = &device->dev;  
> >
> > Hmm. we should probably push this boilerplate into
> > devm_iio_trigger_alloc() like we have done for iio devices.  
> Done in a separate patch. I only clean up obvious calls to set
> trig->dev.parent.
> Looking at the code, some triggers parents are set to the request
> device in more convoluted ways or the grand parent.

Yup. There are a few interesting devices out there, particularly
when mfd's are involved.  Whilst I'm not sure it's actually
necessary for them to set the parents as they do, it is now
ABI so we are stuck with it.

Thanks for that series btw.

Jonathan


> >  
> > > +     iio_trigger_set_drvdata(als->trig, indio_dev);
> > > +     ret = iio_trigger_register(als->trig);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     ret = devm_iio_triggered_buffer_setup(&device->dev,
> > > +                                           indio_dev,
> > > +                                           iio_pollfunc_store_time,
> > > +                                           acpi_als_trigger_handler,
> > > +                                           NULL);
> > > +     if (ret)
> > > +             return ret;
> > >
> > >       return devm_iio_device_register(&device->dev, indio_dev);
> > >  }  
> >  

