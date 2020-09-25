Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05F99278C98
	for <lists+linux-iio@lfdr.de>; Fri, 25 Sep 2020 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgIYP0h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Sep 2020 11:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729041AbgIYP0h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Sep 2020 11:26:37 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6F3C0613D4
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2020 08:26:36 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id i26so4132279ejb.12
        for <linux-iio@vger.kernel.org>; Fri, 25 Sep 2020 08:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MzAtS5pp4wKZdqYxm3un6roUYuqJtBuwsuQz9RJF5Yc=;
        b=DzeQK3aABgVqnhtf+JB9A0bO29QBHxl/mqzmoOtm+NL9CIIGpXMGoBqC1stGMySpRB
         EwbqglUvAoaeO0gRjZy7CodfHU5mTCWx/Xrj6qhU+0OPAQRyzGw3/Qd8uc2iF7gR4M42
         6ek29i+J1uZdWDK2HQd3M8r5yucLm6bZXQG2uH4gEoXMMEQefyEGtPv4SDpTjI9pPA0y
         IMHymF/TA6gnJP5BNt314PwYAxuBGm0lJUwMAuq6RcNUcmw6gWW5oXbVO0kQfJp2EAde
         iidJA8z43PZINmj0czjZG1nlfk7d1r9NQpyhvpPrwa6kbTr5cjDS7Ra/vbkmwmq9VZIz
         sCPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MzAtS5pp4wKZdqYxm3un6roUYuqJtBuwsuQz9RJF5Yc=;
        b=jVEFsA29xkE+0FMUMYPcF+9757LY5Rt+B3+TYv0LNLgqZr/22680QsT2NqBKEdeKPz
         8AbGiSpLK4MXo4tBpeQkguOO4K9AVMM+qtfZFpYPf+CFcHFDyEqBYXAfOTmG+ZMN37/s
         91sE7DskHv+x/adrmqaDTJgBlg1mtpUYrYxE48MdSdhx2MOCiRsxKa8/EnFWIOUssk4W
         rARNGDUCQiBklsiNgJRAZ3zFmVNZ8O0Bm4dV9hZ2MCFznAwHxGhAZJBqaNjWRw/CCbdH
         Cw93izD2WRxJfXGx08yacBOm0fflodIK2SMH9PI9yrmwppTg1AANQ0BEiamyeAQesGGd
         3E1w==
X-Gm-Message-State: AOAM530g91ES7k7OiAbRnIqPv+TDczAYBY5fO/19GWrhQSot8ehKTwUm
        oQL8k3gqGoHUQZ2ryp5stjz0kGO7WFvGIPEfh8SIsA==
X-Google-Smtp-Source: ABdhPJwAxm0uho96sgjawV6ygVNsek+KPJIlPtlIS8KiCCz4rT7hlrStPnUrm7e7riFl2ig9jvhhA7Sn7QwfoxTybP8=
X-Received: by 2002:a17:906:1a4b:: with SMTP id j11mr3148301ejf.97.1601047594921;
 Fri, 25 Sep 2020 08:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200923130339.997902-1-alexandru.ardelean@analog.com> <20200925133301.4789c47a@archlinux>
In-Reply-To: <20200925133301.4789c47a@archlinux>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 25 Sep 2020 08:26:23 -0700
Message-ID: <CABXOdTdr52ikhoSEMqqFakO42hZzpvtH=rxkAYWQsExrnWodFA@mail.gmail.com>
Subject: Re: [PATCH] iio: cros_ec: unify hw fifo attributes into the core file
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Sep 25, 2020 at 5:33 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Wed, 23 Sep 2020 16:03:39 +0300
> Alexandru Ardelean <alexandru.ardelean@analog.com> wrote:
>
> > The intent here is to minimize the use of iio_buffer_set_attrs(). Since we
> > are planning to add support for multiple IIO buffers per IIO device, the
> > issue has to do with:
> > 1. Accessing 'indio_dev->buffer' directly (as is done with
> >    'iio_buffer_set_attrs(indio_dev->buffer, <attrs>)').
> > 2. The way that the buffer attributes would get handled or expanded when
> >    there are more buffers per IIO device. Current a sysfs kobj_type expands
> >    into a 'device' object that expands into an 'iio_dev' object.
> >    We will need to change this, so that the sysfs attributes for IIO
> >    buffers expand into IIO buffers at some point.
> >
> > Right now, the current IIO framework works fine for the
> > '1 IIO device == 1 IIO buffer' case (that is now).
> >
> > Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Looks good to me, but I'll need a cros_ec ack for this one.
>

I like it.

Reviewed-by: Guenter Roeck <groeck@chromium.org>

Guenter

> thanks
>
> Jonathan
>
> > ---
> >  drivers/iio/accel/cros_ec_accel_legacy.c              |  2 +-
> >  .../iio/common/cros_ec_sensors/cros_ec_lid_angle.c    |  3 ++-
> >  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c  |  5 ++---
> >  .../iio/common/cros_ec_sensors/cros_ec_sensors_core.c | 11 ++++++++---
> >  drivers/iio/light/cros_ec_light_prox.c                |  5 ++---
> >  drivers/iio/pressure/cros_ec_baro.c                   |  5 ++---
> >  include/linux/iio/common/cros_ec_sensors_core.h       |  4 ++--
> >  7 files changed, 19 insertions(+), 16 deletions(-)
> >
> > diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> > index b6f3471b62dc..8f1232c38e0d 100644
> > --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> > +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> > @@ -215,7 +215,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
> >               return -ENOMEM;
> >
> >       ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> > -                                     cros_ec_sensors_capture, NULL);
> > +                                     cros_ec_sensors_capture, NULL, false);
> >       if (ret)
> >               return ret;
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > index af801e203623..752f59037715 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > @@ -97,7 +97,8 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
> >       if (!indio_dev)
> >               return -ENOMEM;
> >
> > -     ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL, NULL);
> > +     ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL,
> > +                                     NULL, false);
> >       if (ret)
> >               return ret;
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > index 130ab8ce0269..57038ca48d93 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > @@ -236,12 +236,11 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
> >
> >       ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> >                                       cros_ec_sensors_capture,
> > -                                     cros_ec_sensors_push_data);
> > +                                     cros_ec_sensors_push_data,
> > +                                     true);
> >       if (ret)
> >               return ret;
> >
> > -     iio_buffer_set_attrs(indio_dev->buffer, cros_ec_sensor_fifo_attributes);
> > -
> >       indio_dev->info = &ec_sensors_info;
> >       state = iio_priv(indio_dev);
> >       for (channel = state->channels, i = CROS_EC_SENSOR_X;
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index ea480c1d4349..0de800d41978 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -174,12 +174,11 @@ static ssize_t hwfifo_watermark_max_show(struct device *dev,
> >
> >  static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
> >
> > -const struct attribute *cros_ec_sensor_fifo_attributes[] = {
> > +static const struct attribute *cros_ec_sensor_fifo_attributes[] = {
> >       &iio_dev_attr_hwfifo_timeout.dev_attr.attr,
> >       &iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
> >       NULL,
> >  };
> > -EXPORT_SYMBOL_GPL(cros_ec_sensor_fifo_attributes);
> >
> >  int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
> >                             s16 *data,
> > @@ -238,6 +237,7 @@ static void cros_ec_sensors_core_clean(void *arg)
> >   *    for backward compatibility.
> >   * @push_data:          function to call when cros_ec_sensorhub receives
> >   *    a sample for that sensor.
> > + * @has_hw_fifo:     Set true if this device has/uses a HW FIFO
> >   *
> >   * Return: 0 on success, -errno on failure.
> >   */
> > @@ -245,7 +245,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >                             struct iio_dev *indio_dev,
> >                             bool physical_device,
> >                             cros_ec_sensors_capture_t trigger_capture,
> > -                           cros_ec_sensorhub_push_data_cb_t push_data)
> > +                           cros_ec_sensorhub_push_data_cb_t push_data,
> > +                           bool has_hw_fifo)
> >  {
> >       struct device *dev = &pdev->dev;
> >       struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
> > @@ -358,6 +359,10 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >                                       NULL);
> >                       if (ret)
> >                               return ret;
> > +
> > +                     if (has_hw_fifo)
> > +                             iio_buffer_set_attrs(indio_dev->buffer,
> > +                                                  cros_ec_sensor_fifo_attributes);
> >               }
> >       }
> >
> > diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> > index fed79ba27fda..75d6b5fcf2cc 100644
> > --- a/drivers/iio/light/cros_ec_light_prox.c
> > +++ b/drivers/iio/light/cros_ec_light_prox.c
> > @@ -182,12 +182,11 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
> >
> >       ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> >                                       cros_ec_sensors_capture,
> > -                                     cros_ec_sensors_push_data);
> > +                                     cros_ec_sensors_push_data,
> > +                                     true);
> >       if (ret)
> >               return ret;
> >
> > -     iio_buffer_set_attrs(indio_dev->buffer, cros_ec_sensor_fifo_attributes);
> > -
> >       indio_dev->info = &cros_ec_light_prox_info;
> >       state = iio_priv(indio_dev);
> >       state->core.type = state->core.resp->info.type;
> > diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> > index f0938b6fbba0..aa043cb9ac42 100644
> > --- a/drivers/iio/pressure/cros_ec_baro.c
> > +++ b/drivers/iio/pressure/cros_ec_baro.c
> > @@ -139,12 +139,11 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
> >
> >       ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> >                                       cros_ec_sensors_capture,
> > -                                     cros_ec_sensors_push_data);
> > +                                     cros_ec_sensors_push_data,
> > +                                     true);
> >       if (ret)
> >               return ret;
> >
> > -     iio_buffer_set_attrs(indio_dev->buffer, cros_ec_sensor_fifo_attributes);
> > -
> >       indio_dev->info = &cros_ec_baro_info;
> >       state = iio_priv(indio_dev);
> >       state->core.type = state->core.resp->info.type;
> > diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> > index caa8bb279a34..c9b80be82440 100644
> > --- a/include/linux/iio/common/cros_ec_sensors_core.h
> > +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> > @@ -96,7 +96,8 @@ struct platform_device;
> >  int cros_ec_sensors_core_init(struct platform_device *pdev,
> >                             struct iio_dev *indio_dev, bool physical_device,
> >                             cros_ec_sensors_capture_t trigger_capture,
> > -                           cros_ec_sensorhub_push_data_cb_t push_data);
> > +                           cros_ec_sensorhub_push_data_cb_t push_data,
> > +                           bool has_hw_fifo);
> >
> >  irqreturn_t cros_ec_sensors_capture(int irq, void *p);
> >  int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
> > @@ -125,6 +126,5 @@ extern const struct dev_pm_ops cros_ec_sensors_pm_ops;
> >
> >  /* List of extended channel specification for all sensors. */
> >  extern const struct iio_chan_spec_ext_info cros_ec_sensors_ext_info[];
> > -extern const struct attribute *cros_ec_sensor_fifo_attributes[];
> >
> >  #endif  /* __CROS_EC_SENSORS_CORE_H */
>
