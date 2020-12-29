Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17DBE2E7298
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 18:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726161AbgL2RZY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 12:25:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:48178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgL2RZY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 12:25:24 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4AD4E21D94;
        Tue, 29 Dec 2020 17:24:42 +0000 (UTC)
Date:   Tue, 29 Dec 2020 17:24:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 3/3] iio: acpi_als: Add trigger support
Message-ID: <20201229172439.2a65580f@archlinux>
In-Reply-To: <CAHp75Vfn=KtzN7zpm+pRES3L6R9k77GhHUFkxjrHcV67Vwx7kA@mail.gmail.com>
References: <20201216214107.774969-1-gwendal@chromium.org>
        <20201216214107.774969-4-gwendal@chromium.org>
        <CAHp75Vfn=KtzN7zpm+pRES3L6R9k77GhHUFkxjrHcV67Vwx7kA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 17 Dec 2020 00:38:06 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Wed, Dec 16, 2020 at 11:41 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > As some firmware does not notify on illuminance changes, add a
> > trigger to be able to query light via software (sysfs-trigger or
> > hrtrigger).
> > Add a hardware trigger set as the default trigger to maintain backward
> > compatibility.
> >
> > Check iio_info reports the sensor as buffer capable:
> >   iio:device0: acpi-als (buffer capable)
> >
> > To test, check we can get data on demand on an Intel based chromebook:
> >
> >   IIO_DEV="iio:device0"
> >   echo 1 > iio_sysfs_trigger/add_trigger
> >   cat trigger2/name > ${IIO_DEV}/trigger/current_trigger
> >   for i in ${IIO_DEV}/scan_elements/*_en ${IIO_DEV}/buffer/enable ; do
> >     echo 1 > $i
> >   done
> >   od -x /dev/${IIO_DEV} &
> >   echo 1 > trigger2/trigger_now  
> 
> Few nitpicks below. After addressing, take my
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> assuming that backward compatibility has been tested as well.
> 
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  Changes in v4:
> >  Added comments when pf->timestamp is 0 and valid. Fix spelling.
> >  Changes in v5:
> >  Improve commit message readability, add note about backward
> >  compatibility.
> >  Remove unneeded include file.
> >
> >  drivers/iio/light/acpi-als.c | 89 ++++++++++++++++++++++++++----------
> >  1 file changed, 66 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> > index fd20808d4a119..80fe0da51fad3 100644
> > --- a/drivers/iio/light/acpi-als.c
> > +++ b/drivers/iio/light/acpi-als.c
> > @@ -16,11 +16,14 @@
> >  #include <linux/module.h>
> >  #include <linux/acpi.h>
> >  #include <linux/err.h>
> > +#include <linux/irq.h>
> >  #include <linux/mutex.h>
> >
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/buffer.h>
> > -#include <linux/iio/kfifo_buf.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> >
> >  #define ACPI_ALS_CLASS                 "als"
> >  #define ACPI_ALS_DEVICE_NAME           "acpi-als"
> > @@ -59,6 +62,7 @@ static const struct iio_chan_spec acpi_als_channels[] = {
> >  struct acpi_als {
> >         struct acpi_device      *device;
> >         struct mutex            lock;
> > +       struct iio_trigger      *trig;
> >
> >         s32 evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE / sizeof(s32)]  __aligned(8);
> >  };
> > @@ -102,33 +106,20 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
> >  {
> >         struct iio_dev *indio_dev = acpi_driver_data(device);
> >         struct acpi_als *als = iio_priv(indio_dev);
> > -       s32 *buffer = als->evt_buffer;
> > -       s64 time_ns = iio_get_time_ns(indio_dev);
> > -       s32 val;
> > -       int ret;
> >
> > -       mutex_lock(&als->lock);
> > -
> > -       memset(buffer, 0, ACPI_ALS_EVT_BUFFER_SIZE);
> > +       if (!iio_buffer_enabled(indio_dev) ||
> > +           !iio_trigger_using_own(indio_dev))  
> 
> I guess it can be located on one line.
> 
> I hope those functions have no side effects. In that case you may
> invert logic (save 2 characters)
> 
>        if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))

You can but at cost of indenting the whole following block on level further.
I'm not that fussed, but in general that doesn't seem like a good idea to
save two characters here.

Gwendal made that not too bad in v6 by removing the read that appears to
be unnecessary.



> 
> > +               return;
> >
> >         switch (event) {
> >         case ACPI_ALS_NOTIFY_ILLUMINANCE:
> > -               ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
> > -               if (ret < 0)
> > -                       goto out;
> > -               *buffer++ = val;
> > +               iio_trigger_poll_chained(als->trig);
> >                 break;
> >         default:
> >                 /* Unhandled event */
> >                 dev_dbg(&device->dev, "Unhandled ACPI ALS event (%08x)!\n",
> >                         event);
> > -               goto out;
> >         }
> > -
> > -       iio_push_to_buffers_with_timestamp(indio_dev, als->evt_buffer, time_ns);
> > -
> > -out:
> > -       mutex_unlock(&als->lock);
> >  }
> >
> >  static int acpi_als_read_raw(struct iio_dev *indio_dev,
> > @@ -159,12 +150,47 @@ static const struct iio_info acpi_als_info = {
> >         .read_raw               = acpi_als_read_raw,
> >  };
> >
> > +static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
> > +{
> > +       struct iio_poll_func *pf = p;
> > +       struct iio_dev *indio_dev = pf->indio_dev;
> > +       struct acpi_als *als = iio_priv(indio_dev);
> > +       s32 *buffer = als->evt_buffer;
> > +       s32 val;
> > +       int ret;
> > +
> > +       mutex_lock(&als->lock);
> > +
> > +       ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
> > +       if (ret < 0)
> > +               goto out;
> > +       *buffer = val;
> > +
> > +       /*
> > +        * When coming from own trigger via polls, set polling function timestamp
> > +        * here.
> > +        * Given ACPI notifier is already in a thread and call function directly,
> > +        * there is no need to set the timestamp in the notify function.  
> 
> Continue the second sentence of the previous line. No need to have it
> in a separate paragraph.
> 
> > +        *
> > +        * If the timestamp was actually 0, the timestamp is set one more time.
> > +        */
> > +       if (!pf->timestamp)
> > +               pf->timestamp = iio_get_time_ns(indio_dev);
> > +
> > +       iio_push_to_buffers_with_timestamp(indio_dev, buffer, pf->timestamp);
> > +out:
> > +       mutex_unlock(&als->lock);
> > +       iio_trigger_notify_done(indio_dev->trig);
> > +
> > +       return IRQ_HANDLED;
> > +}
> > +
> >  static int acpi_als_add(struct acpi_device *device)
> >  {
> >         struct device *dev = &device->dev;
> >         struct iio_dev *indio_dev;
> > -       struct iio_buffer *buffer;
> >         struct acpi_als *als;
> > +       int ret;
> >
> >         indio_dev = devm_iio_device_alloc(dev, sizeof(*als));
> >         if (!indio_dev)
> > @@ -178,15 +204,32 @@ static int acpi_als_add(struct acpi_device *device)
> >
> >         indio_dev->name = ACPI_ALS_DEVICE_NAME;
> >         indio_dev->info = &acpi_als_info;
> > -       indio_dev->modes = INDIO_BUFFER_SOFTWARE;
> > +       indio_dev->modes = INDIO_DIRECT_MODE;
> >         indio_dev->channels = acpi_als_channels;
> >         indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
> >
> > -       buffer = devm_iio_kfifo_allocate(dev);
> > -       if (!buffer)
> > +       als->trig = devm_iio_trigger_alloc(dev, "%s-dev%d",
> > +                                          indio_dev->name,
> > +                                          indio_dev->id);
> > +       if (!als->trig)
> >                 return -ENOMEM;
> >
> > -       iio_device_attach_buffer(indio_dev, buffer);
> > +       iio_trigger_set_drvdata(als->trig, indio_dev);
> > +       ret = devm_iio_trigger_register(dev, als->trig);
> > +       if (ret)
> > +               return ret;
> > +       /*
> > +        * Set hardware trigger by default to let events flow when
> > +        * BIOS support notification.
> > +        */
> > +       indio_dev->trig = iio_trigger_get(als->trig);
> > +
> > +       ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> > +                                             iio_pollfunc_store_time,
> > +                                             acpi_als_trigger_handler,
> > +                                             NULL);
> > +       if (ret)
> > +               return ret;
> >
> >         return devm_iio_device_register(dev, indio_dev);
> >  }
> > --
> > 2.29.2.729.g45daf8777d-goog
> >  
> 
> 

