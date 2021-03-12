Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD024338285
	for <lists+linux-iio@lfdr.de>; Fri, 12 Mar 2021 01:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbhCLApO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Mar 2021 19:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhCLAoo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Mar 2021 19:44:44 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C37AC061574
        for <linux-iio@vger.kernel.org>; Thu, 11 Mar 2021 16:44:44 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id s1so1032898ilh.12
        for <linux-iio@vger.kernel.org>; Thu, 11 Mar 2021 16:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3cDbyMq+QdDt19B1IyOzO4nlRZ8Ag6YJA2pNVDpLos=;
        b=K3s6evQajKdT504lZ5Ovc/m/XqMINIy+6n17tUI0PYMYw2OjQGNjCl8pOw5qloIVqe
         eX/7lU2C1uzPVwf2szYx6I8Jm3RDO4Cjy0ozOGBWQok+D3HKq5crUGCtwoz3G1ZktV1h
         utk/aFvmGvSbks4LZjBbHBEfZUWHLuJHNoKjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3cDbyMq+QdDt19B1IyOzO4nlRZ8Ag6YJA2pNVDpLos=;
        b=aKOMG9bTInil2AJL5KtdNiRvo1A4N/W6L6vcJWg3X0c8mCovLwXa5o8p9MHB6l7TGd
         6SxXq0bgDlwx5GDiMHHZQUX6/C5/hwEjhwKBI8tRbgBUBim3sNLesscK7ai7sZuDDgpc
         gxriuLJxLdDv4bavPb01ZZGtDGs/tuqG6WHtEMvILsUdWiyksyI99hvKwJFDlYsIzM3P
         U0slHmyYTnwihRI8TXW+OtRxFDSlyDW/1GM8l0xmLThiNlmnFHpkPeiGLyv876EWj/e8
         n8K0nifH2moX781AW2wfIy6uGEgkdBTqcMA5p33m03iNF2PRkejhtZGS4lmOlriX4PDR
         7qyg==
X-Gm-Message-State: AOAM532RtCwP7f27b4BNNdLAKH9DNiIdrOcsnQEc7AqlwZVQGjD0/qmc
        KCJCJKpjAhB9ioOfZknC2831Lcr+TQanOyj+mdRfVA==
X-Google-Smtp-Source: ABdhPJz1rPh36hWgsqlDUgS4XPkWxoasI3NWGUQdVmMP2gyMlCZ66BlDUNHHABdnuOxuHv252Z1ndQ9aSAupZtgySL4=
X-Received: by 2002:a92:c644:: with SMTP id 4mr878876ill.237.1615509882833;
 Thu, 11 Mar 2021 16:44:42 -0800 (PST)
MIME-Version: 1.0
References: <20210310071334.3204344-1-gwendal@chromium.org>
 <CA+U=DsqJGFeEiaAXJ=sY=QmaPjESpJ4WmWAqEEHO-TW8-tQjEw@mail.gmail.com>
 <CAPUE2ut3b2-LfwKQhB47Fq5URAGTMNvmYU-DjWQMEwXx0yOAEA@mail.gmail.com> <CA+U=Dspk3cWjiiRmDrgfHAY6houjr-KtSD3u4BssUcb=c2ujpQ@mail.gmail.com>
In-Reply-To: <CA+U=Dspk3cWjiiRmDrgfHAY6houjr-KtSD3u4BssUcb=c2ujpQ@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Thu, 11 Mar 2021 16:44:29 -0800
Message-ID: <CAPUE2ut5FqVc3uYcKvTUMkUpganPdHXxzikoRxAh6WLx+UAkfQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: cros: unify hw fifo attributes without API changes
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 11, 2021 at 12:14 AM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Thu, Mar 11, 2021 at 1:09 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Uploading a V3. I would not need to use a trigger, if there was a
> > function devm_iio_kfifo_buffer_setup_ext() that like
> > iio_triggered_buffer_setup_ext would set buffer->attrs.
>
> Btw: my @analog.com email will become inactive in a few weeks.
>
> If you need a devm_iio_kfifo_buffer_setup_ext(), I don't see a reason
> not to add one.
> Similar to {devm_}iio_triggered_buffer_setup_ext().
> Unless someone else objects.
>
> These HW FIFO via buffer->attrs are common to other drivers [I
> remember around 5] and they look like they could be implemented as
> some generic mechanism inside IIO.
> The iio_triggered_buffer_setup_ext()/devm_iio_kfifo_buffer_setup_ext()
> functions [which are used to pass these attributes] are a bit of a
> temporary mechanism until this somehow moves into some IIO core logic.
>
> I can spin-up a patch to create a devm_iio_kfifo_buffer_setup_ext() if
> that helps.
The v4 patch does not need that new function and if you plan to
continue refactoring anyway that does not make sense to add a new
function.
>
> >
> > Gwendal.
> >
> > On Tue, Mar 9, 2021 at 11:49 PM Alexandru Ardelean
> > <ardeleanalex@gmail.com> wrote:
> > >
> > > On Wed, Mar 10, 2021 at 9:15 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> > > >
> > > > fixes commit 2e2366c2d141 ("iio: cros_ec: unify hw fifo attributes into the core file")
> > > > fixes commit 165aea80e2e2 ("iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()")
> > > >
> > >
> > > Apologies for not noticing this earlier.
> > > But could you rework this patch on top of this commit?
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?id=c3f59df11a01dcdcd0c5a60563b7b5d4d8fceca2
> > >
> > > It's only in Jonathan's tree, in the iio/testing branch.
> > >
> > > There's that new devm_iio_kfifo_buffer_setup() function that got
> > > introduced recently, mostly to get rid of the
> > > iio_device_attach_buffer() call.
> > > Also, the `linux/iio/buffer_impl.h` include can now be removed now.
> > >
> > > > 1. Instead of adding has_fw_fifo, deduct it from the configuration:
> > > > - EC must support FIFO (EC_FEATURE_MOTION_SENSE_FIFO) set.
> > > > - sensors send data a regular interval (accelerometer, gyro,
> > > >   magnetomer, barometer, light sensor).
> > > > - "Legacy accelerometer" is only present on EC without FIFO, so we don't
> > > > need to set buffer attributes.
> > > >
> > > > 2. devm_iio_triggered_buffer_setup_ext() does not need to be called when
> > > > EC does not support FIFO, as there is no FIFO to manage.
> > > >
> > > > 3. Create a triggered buffer with devm_iio_triggered_buffer_setup_ext() when
> > > > the EC support FIFO as it is the only clean way to set the
> > > > buffer extended attributes.
> > > > Add a slim trigger to be sure the samples can flow via callback from the
> > > > EC FIFO to the IIO buffer.
> > > >
> > > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > > ---
> > > >  drivers/iio/accel/cros_ec_accel_legacy.c      |  2 +-
> > > >  .../cros_ec_sensors/cros_ec_lid_angle.c       |  3 +-
> > > >  .../common/cros_ec_sensors/cros_ec_sensors.c  |  3 +-
> > > >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 58 +++++++++++--------
> > > >  drivers/iio/light/cros_ec_light_prox.c        |  3 +-
> > > >  drivers/iio/pressure/cros_ec_baro.c           |  3 +-
> > > >  .../linux/iio/common/cros_ec_sensors_core.h   |  3 +-
> > > >  7 files changed, 41 insertions(+), 34 deletions(-)
> > > >
> > > > diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> > > > index 8f1232c38e0d7..b6f3471b62dcf 100644
> > > > --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> > > > +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> > > > @@ -215,7 +215,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
> > > >                 return -ENOMEM;
> > > >
> > > >         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> > > > -                                       cros_ec_sensors_capture, NULL, false);
> > > > +                                       cros_ec_sensors_capture, NULL);
> > > >         if (ret)
> > > >                 return ret;
> > > >
> > > > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > > > index 752f59037715b..af801e203623e 100644
> > > > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > > > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > > > @@ -97,8 +97,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
> > > >         if (!indio_dev)
> > > >                 return -ENOMEM;
> > > >
> > > > -       ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL,
> > > > -                                       NULL, false);
> > > > +       ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL, NULL);
> > > >         if (ret)
> > > >                 return ret;
> > > >
> > > > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > > > index dee1191de7528..376a5b30010ae 100644
> > > > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > > > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > > > @@ -236,8 +236,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
> > > >
> > > >         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> > > >                                         cros_ec_sensors_capture,
> > > > -                                       cros_ec_sensors_push_data,
> > > > -                                       true);
> > > > +                                       cros_ec_sensors_push_data);
> > > >         if (ret)
> > > >                 return ret;
> > > >
> > > > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > > index c833ec0ef2147..8ee89c4314a61 100644
> > > > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > > @@ -8,10 +8,12 @@
> > > >  #include <linux/delay.h>
> > > >  #include <linux/device.h>
> > > >  #include <linux/iio/buffer.h>
> > > > +#include <linux/iio/buffer_impl.h>
> > > >  #include <linux/iio/common/cros_ec_sensors_core.h>
> > > >  #include <linux/iio/iio.h>
> > > >  #include <linux/iio/kfifo_buf.h>
> > > >  #include <linux/iio/sysfs.h>
> > > > +#include <linux/iio/trigger.h>
> > > >  #include <linux/iio/trigger_consumer.h>
> > > >  #include <linux/iio/triggered_buffer.h>
> > > >  #include <linux/kernel.h>
> > > > @@ -240,7 +242,6 @@ static void cros_ec_sensors_core_clean(void *arg)
> > > >   *    for backward compatibility.
> > > >   * @push_data:          function to call when cros_ec_sensorhub receives
> > > >   *    a sample for that sensor.
> > > > - * @has_hw_fifo:       Set true if this device has/uses a HW FIFO
> > > >   *
> > > >   * Return: 0 on success, -errno on failure.
> > > >   */
> > > > @@ -248,8 +249,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> > > >                               struct iio_dev *indio_dev,
> > > >                               bool physical_device,
> > > >                               cros_ec_sensors_capture_t trigger_capture,
> > > > -                             cros_ec_sensorhub_push_data_cb_t push_data,
> > > > -                             bool has_hw_fifo)
> > > > +                             cros_ec_sensorhub_push_data_cb_t push_data)
> > > >  {
> > > >         struct device *dev = &pdev->dev;
> > > >         struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
> > > > @@ -329,22 +329,41 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> > > >                 }
> > > >
> > > >                 if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
> > > > +                       struct iio_trigger *trig;
> > > > +
> > > >                         /*
> > > > -                        * Create a software buffer, feed by the EC FIFO.
> > > > -                        * We can not use trigger here, as events are generated
> > > > -                        * as soon as sample_frequency is set.
> > > > +                        * Create a triggered buffer to be able to trigger data
> > > > +                        * gathering manually, but by default, samples come from
> > > > +                        * the EC FIFO.
> > > >                          */
> > > > -                       struct iio_buffer *buffer;
> > > > +                       ret = devm_iio_triggered_buffer_setup_ext(dev, indio_dev,
> > > > +                                       NULL, trigger_capture, NULL,
> > > > +                                       cros_ec_sensor_fifo_attributes);
> > > > +                       if (ret)
> > > > +                               return ret;
> > > >
> > > > -                       buffer = devm_iio_kfifo_allocate(dev);
> > > > -                       if (!buffer)
> > > > +                       /*
> > > > +                        * Register a trigger as plug to allow samples from the
> > > > +                        * FIFO to flow.
> > > > +                        * When cros-ec-sensor-ring is present, samples produced
> > > > +                        * by the EC FIFO are directed to that ring only.
> > > > +                        */
> > > > +                       trig = devm_iio_trigger_alloc(dev, "cros_ec%d-dev%d",
> > > > +                                       sensor_platform->sensor_num, indio_dev->id);
> > > > +                       if (!trig)
> > > >                                 return -ENOMEM;
> > > >
> > > > -                       iio_device_attach_buffer(indio_dev, buffer);
> > > > -                       indio_dev->modes = INDIO_BUFFER_SOFTWARE;
> > > > +                       ret = devm_iio_trigger_register(dev, trig);
> > > > +                       if (ret < 0)
> > > > +                               return ret;
> > > > +                       indio_dev->trig = iio_trigger_get(trig);
> > > >
> > > > -                       ret = cros_ec_sensorhub_register_push_data(
> > > > -                                       sensor_hub, sensor_platform->sensor_num,
> > > > +                       /*
> > > > +                        * Register the callback to use when a sensor sample is
> > > > +                        * coming from the EC FIFO.
> > > > +                        */
> > > > +                       ret = cros_ec_sensorhub_register_push_data(sensor_hub,
> > > > +                                       sensor_platform->sensor_num,
> > > >                                         indio_dev, push_data);
> > > >                         if (ret)
> > > >                                 return ret;
> > > > @@ -358,21 +377,14 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> > > >                         ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
> > > >                         if (ret)
> > > >                                 return ret;
> > > > -               } else {
> > > > -                       const struct attribute **fifo_attrs;
> > > > -
> > > > -                       if (has_hw_fifo)
> > > > -                               fifo_attrs = cros_ec_sensor_fifo_attributes;
> > > > -                       else
> > > > -                               fifo_attrs = NULL;
> > > >
> > > > +               } else {
> > > >                         /*
> > > >                          * The only way to get samples in buffer is to set a
> > > >                          * software trigger (systrig, hrtimer).
> > > >                          */
> > > > -                       ret = devm_iio_triggered_buffer_setup_ext(
> > > > -                                       dev, indio_dev, NULL, trigger_capture,
> > > > -                                       NULL, fifo_attrs);
> > > > +                       ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> > > > +                                       NULL, trigger_capture, NULL);
> > > >                         if (ret)
> > > >                                 return ret;
> > > >                 }
> > > > diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> > > > index 75d6b5fcf2cc4..de472f23d1cba 100644
> > > > --- a/drivers/iio/light/cros_ec_light_prox.c
> > > > +++ b/drivers/iio/light/cros_ec_light_prox.c
> > > > @@ -182,8 +182,7 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
> > > >
> > > >         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> > > >                                         cros_ec_sensors_capture,
> > > > -                                       cros_ec_sensors_push_data,
> > > > -                                       true);
> > > > +                                       cros_ec_sensors_push_data);
> > > >         if (ret)
> > > >                 return ret;
> > > >
> > > > diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> > > > index aa043cb9ac426..2f882e1094232 100644
> > > > --- a/drivers/iio/pressure/cros_ec_baro.c
> > > > +++ b/drivers/iio/pressure/cros_ec_baro.c
> > > > @@ -139,8 +139,7 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
> > > >
> > > >         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> > > >                                         cros_ec_sensors_capture,
> > > > -                                       cros_ec_sensors_push_data,
> > > > -                                       true);
> > > > +                                       cros_ec_sensors_push_data);
> > > >         if (ret)
> > > >                 return ret;
> > > >
> > > > diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> > > > index c9b80be82440f..7ce8a8adad587 100644
> > > > --- a/include/linux/iio/common/cros_ec_sensors_core.h
> > > > +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> > > > @@ -96,8 +96,7 @@ struct platform_device;
> > > >  int cros_ec_sensors_core_init(struct platform_device *pdev,
> > > >                               struct iio_dev *indio_dev, bool physical_device,
> > > >                               cros_ec_sensors_capture_t trigger_capture,
> > > > -                             cros_ec_sensorhub_push_data_cb_t push_data,
> > > > -                             bool has_hw_fifo);
> > > > +                             cros_ec_sensorhub_push_data_cb_t push_data);
> > > >
> > > >  irqreturn_t cros_ec_sensors_capture(int irq, void *p);
> > > >  int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
> > > > --
> > > > 2.30.1.766.gb4fecdf3b7-goog
> > > >
