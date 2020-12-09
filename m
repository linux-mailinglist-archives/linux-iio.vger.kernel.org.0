Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86D32D4E12
	for <lists+linux-iio@lfdr.de>; Wed,  9 Dec 2020 23:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388247AbgLIWht (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Dec 2020 17:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgLIWho (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Dec 2020 17:37:44 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4509C0613CF
        for <linux-iio@vger.kernel.org>; Wed,  9 Dec 2020 14:37:03 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id q1so3258398ilt.6
        for <linux-iio@vger.kernel.org>; Wed, 09 Dec 2020 14:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jyf5dNBiCd028nBbI64LgxOI956zFAqi5ms22b5aU98=;
        b=SX9MOgjCz7hFgim9YnCCe/BujT0oRYxkHiwSz75EG146Wza3GNcM9gjZYaaud2XguH
         V1VRJ3GaQ9Kgc5A4ninbZyJ15/db71I3OUXyV+SyA4QAVKSAcR6QOwIilWG69XMF5IhW
         v94dM+sQh1T4H2nqKvVbLBFJb5N876R2wIYsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jyf5dNBiCd028nBbI64LgxOI956zFAqi5ms22b5aU98=;
        b=VpY3MKFjw1zNyDP2paN/ncO4DGXAnV1VZ7Bo2JchjaBFw439rX+nA3s8ZDHzdNoDzv
         Bg/DwwT/051LozsleyW6SW5HSMqiDzb6OGtGk4Vy7joET7+G3mhJ13Mk9hUWzqr4hanJ
         DotCbl6OsluFTz/fJX2RvgykItB1rWxtYt0sKeu10hKhocAPiZyQ9NjxA7X/U7bE/IBr
         gy+kv5wxwKfd9zdnbyjJc/HcEh6l52ufFKYORW6xLLHTMxVCoAYeWY4Fmr4TIqPQKJjh
         DhyGtHjqtsKgDtjVDJHkcR11WCtiyv8alygBSxTgHKyUG7/s5E844Kyx4nXAFsGSaA9f
         G2MA==
X-Gm-Message-State: AOAM531TEUquxYH72xwivY/p6v/+aSgc7ewteUlhVKJIMk0f5jvob3/7
        DAYD6OvnDDVc7Zvkwc9PX/rOwzYNzSrK04okWmJupxndbpP6jg==
X-Google-Smtp-Source: ABdhPJxa6N5Pcgi8k+nX9F7cSHiEVsf3YqhduSTvl1gxNIwgO5NBlafLyLtN/UqDXrN711WsvY2WtrCkTSokk2MfNfg=
X-Received: by 2002:a92:d44f:: with SMTP id r15mr6144066ilm.237.1607553423051;
 Wed, 09 Dec 2020 14:37:03 -0800 (PST)
MIME-Version: 1.0
References: <20201204203755.818932-1-gwendal@chromium.org> <20201205182659.7cd23d5b@archlinux>
In-Reply-To: <20201205182659.7cd23d5b@archlinux>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Wed, 9 Dec 2020 14:36:51 -0800
Message-ID: <CAPUE2utiv5-MPx9LHTn0SLTLGcFgVE2YzNS1U3HhZy0W3F+-jw@mail.gmail.com>
Subject: Re: [PATCH] iio: acpi_als: Add trigger support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Gabriele Mazzotta <gabriele.mzt@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Dec 5, 2020 at 10:27 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri,  4 Dec 2020 12:37:55 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:
>
> > Add timestamp channel: use standard procedure to collect timestamp.
> > As some firmware do not notify on illuminance changes, add a
> > trigger to periodically query light.
> > We can either use the device trigger, or a software trigger like sysfs
> > or hrtimer.
> >
> > This change is not backward compatible. To get samples from bios that
> > supports notification, we need to register the hardware trigger first:
> >
> > echo acpi-als-dev${X} > iio\:device${X}/trigger/current_trigger
>
> That's a problem as we can't break backwards compatibility.
> Note that you can set a default trigger for a device with
>
> indio_dev->trig = iio_trigger_get(trig);
> If we do that then it can still be overridden but at least
> we don't break backwards compatibility.
Done in v2, I now understand the code better.
> We also have an immutable variant if we really don't want
> it to be changed later but I don't think that is true here.
>
> >
> > Check iio_info reports the sensor as buffer capable:
> > iio:device0: acpi-als (buffer capable)
> > Check we can get data on demand:
> > echo 1 > iio_sysfs_trigger/add_trigger
> > cat trigger2/name > iio\:device0/trigger/current_trigger
> > for i in iio\:device0/scan_elements/*_en iio\:device0/buffer/enable ; do
> >   echo 1 > $i
> > done
> > od -x /dev/iio\:device0&
> > echo 1 > trigger2/trigger_now
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/iio/light/acpi-als.c | 86 +++++++++++++++++++++++++-----------
> >  1 file changed, 59 insertions(+), 27 deletions(-)
> >
> > diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> > index 1eafd0b24e182..2619e4b073a59 100644
> > --- a/drivers/iio/light/acpi-als.c
> > +++ b/drivers/iio/light/acpi-als.c
> > @@ -16,11 +16,15 @@
> >  #include <linux/module.h>
> >  #include <linux/acpi.h>
> >  #include <linux/err.h>
> > +#include <linux/irq.h>
> >  #include <linux/mutex.h>
> >
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/buffer.h>
> >  #include <linux/iio/kfifo_buf.h>
> > +#include <linux/iio/trigger.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> >
> >  #define ACPI_ALS_CLASS                       "als"
> >  #define ACPI_ALS_DEVICE_NAME         "acpi-als"
> > @@ -45,22 +49,22 @@ static const struct iio_chan_spec acpi_als_channels[] = {
> >               .info_mask_separate     = BIT(IIO_CHAN_INFO_RAW) |
> >                                         BIT(IIO_CHAN_INFO_PROCESSED),
> >       },
> > +     IIO_CHAN_SOFT_TIMESTAMP(1),
> >  };
> >
> >  /*
> >   * The event buffer contains timestamp and all the data from
> >   * the ACPI0008 block. There are multiple, but so far we only
> > - * support _ALI (illuminance). Once someone adds new channels
> > - * to acpi_als_channels[], the evt_buffer below will grow
> > - * automatically.
> > + * support _ALI (illuminance):
> > + * One channel, paddind and timestamp.
> >   */
> > -#define ACPI_ALS_EVT_NR_SOURCES              ARRAY_SIZE(acpi_als_channels)
> >  #define ACPI_ALS_EVT_BUFFER_SIZE             \
> > -     (sizeof(s64) + (ACPI_ALS_EVT_NR_SOURCES * sizeof(s32)))
> > +     (sizeof(s32) + sizeof(s32) + sizeof(s64))
> >
> >  struct acpi_als {
> >       struct acpi_device      *device;
> >       struct mutex            lock;
> > +     struct iio_trigger      *trig;
> >
> >       s32                     evt_buffer[ACPI_ALS_EVT_BUFFER_SIZE];
> This gets used in iio_push_to_buffers_with_timestamp and that
> has a few not well documented quirks (on list to fix)
> In particular it relies on being able to put the timestamp in
> the right place and side effect of that is that the buffer
> passed to that function must be 8 byte aligned.
> Note I've been working through fixing drivers for this but clearly
> still some to go.
>
> You can probably do that here with __aligned(8)
Done in v2.
>
> As a side note, isn't the buffer way too big?  I think should be
> ACPI_ALS_EVT_BUFFER_SIZE / sizeof(u32)
Done in v2.
>
> >  };
> > @@ -104,33 +108,20 @@ static void acpi_als_notify(struct acpi_device *device, u32 event)
> >  {
> >       struct iio_dev *indio_dev = acpi_driver_data(device);
> >       struct acpi_als *als = iio_priv(indio_dev);
> > -     s32 *buffer = als->evt_buffer;
> > -     s64 time_ns = iio_get_time_ns(indio_dev);
> > -     s32 val;
> > -     int ret;
> > -
> > -     mutex_lock(&als->lock);
> >
> > -     memset(buffer, 0, ACPI_ALS_EVT_BUFFER_SIZE);
> > +     if (!iio_buffer_enabled(indio_dev) ||
> > +         !iio_trigger_using_own(indio_dev))
> > +             return;
> >
> >       switch (event) {
> >       case ACPI_ALS_NOTIFY_ILLUMINANCE:
> > -             ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
> > -             if (ret < 0)
> > -                     goto out;
> > -             *buffer++ = val;
> > +             iio_trigger_poll_chained(als->trig);
>
> One issue with this path is it won't have set the poll function timestamp.
> It's a long term problem that there is no way for a device to know with
> certainty if the top half of it's trigger handler was ever called.
>
> I have been thinking about adding accessors to pf->timestamp to set
> and clear it which could also set a flag to say it had been set.
> Hence the get would return an error if not and we could grab a local
> timestamp if that happens as it would be the best available.
Looking at other devices that support sw/hw riggers (for instance
light/rpr0521.c), pf->timestamp == 0 indicates that the top half was
not called.
>
> Anyhow, I would assume you will get all 0 timestamps currently.
>
> >               break;
> >       default:
> >               /* Unhandled event */
> >               dev_dbg(&device->dev, "Unhandled ACPI ALS event (%08x)!\n",
> >                       event);
> > -             goto out;
> >       }
> > -
> > -     iio_push_to_buffers_with_timestamp(indio_dev, als->evt_buffer, time_ns);
> > -
> > -out:
> > -     mutex_unlock(&als->lock);
> >  }
> >
> >  static int acpi_als_read_raw(struct iio_dev *indio_dev,
> > @@ -161,11 +152,37 @@ static const struct iio_info acpi_als_info = {
> >       .read_raw               = acpi_als_read_raw,
> >  };
> >
> > +static irqreturn_t acpi_als_trigger_handler(int irq, void *p)
> > +{
> > +     struct iio_poll_func *pf = p;
> > +     struct iio_dev *indio_dev = pf->indio_dev;
> > +     struct acpi_als *als = iio_priv(indio_dev);
> > +     s32 *buffer = als->evt_buffer;
> > +     s32 val;
> > +     int ret;
> > +
> > +     mutex_lock(&als->lock);
> > +
> > +     memset(buffer, 0, ACPI_ALS_EVT_BUFFER_SIZE);
>
> This shouldn't be needed. The buffer was originally kzalloc'd
> I believe and we write all the values that might contain stale
> data.
Done
>
> > +     ret = acpi_als_read_value(als, ACPI_ALS_ILLUMINANCE, &val);
> > +     if (ret < 0)
> > +             goto out;
> > +     *buffer++ = val;
> > +
> > +     iio_push_to_buffers_with_timestamp(indio_dev, als->evt_buffer,
> > +                                        pf->timestamp);
>
> Use buffer for evt_buffer here for consistency.
Done
>
> > +out:
> > +     mutex_unlock(&als->lock);
> > +     iio_trigger_notify_done(indio_dev->trig);
> > +
> > +     return IRQ_HANDLED;
> > +}
> > +
> >  static int acpi_als_add(struct acpi_device *device)
> >  {
> >       struct acpi_als *als;
> >       struct iio_dev *indio_dev;
> > -     struct iio_buffer *buffer;
> > +     int ret;
> >
> >       indio_dev = devm_iio_device_alloc(&device->dev, sizeof(*als));
> >       if (!indio_dev)
> > @@ -180,15 +197,30 @@ static int acpi_als_add(struct acpi_device *device)
> >       indio_dev->name = ACPI_ALS_DEVICE_NAME;
> >       indio_dev->dev.parent = &device->dev;
> >       indio_dev->info = &acpi_als_info;
> > -     indio_dev->modes = INDIO_BUFFER_SOFTWARE;
> > +     indio_dev->modes = INDIO_DIRECT_MODE;
> >       indio_dev->channels = acpi_als_channels;
> >       indio_dev->num_channels = ARRAY_SIZE(acpi_als_channels);
> >
> > -     buffer = devm_iio_kfifo_allocate(&device->dev);
> > -     if (!buffer)
> > +     als->trig = devm_iio_trigger_alloc(&device->dev,
> > +                                        "%s-dev%d",
> > +                                        indio_dev->name,
> > +                                        indio_dev->id);
> > +     if (!als->trig)
> >               return -ENOMEM;
> >
> > -     iio_device_attach_buffer(indio_dev, buffer);
> > +     als->trig->dev.parent = &device->dev;
>
> Hmm. we should probably push this boilerplate into
> devm_iio_trigger_alloc() like we have done for iio devices.
Done in a separate patch. I only clean up obvious calls to set
trig->dev.parent.
Looking at the code, some triggers parents are set to the request
device in more convoluted ways or the grand parent.
>
> > +     iio_trigger_set_drvdata(als->trig, indio_dev);
> > +     ret = iio_trigger_register(als->trig);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = devm_iio_triggered_buffer_setup(&device->dev,
> > +                                           indio_dev,
> > +                                           iio_pollfunc_store_time,
> > +                                           acpi_als_trigger_handler,
> > +                                           NULL);
> > +     if (ret)
> > +             return ret;
> >
> >       return devm_iio_device_register(&device->dev, indio_dev);
> >  }
>
