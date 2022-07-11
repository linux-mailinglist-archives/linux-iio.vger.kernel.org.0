Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDCF570617
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 16:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiGKOrn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 10:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiGKOrm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 10:47:42 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE8A6D56B
        for <linux-iio@vger.kernel.org>; Mon, 11 Jul 2022 07:47:40 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id u6so4931692iop.5
        for <linux-iio@vger.kernel.org>; Mon, 11 Jul 2022 07:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3DNXbW3lFA1hCKs/gxZ/BjEHUIQFzhRQhtx/fqIgyBc=;
        b=Yb5mmsnBYkFiNDH8KdA1FVPIYAw2EgBJPwH+f+JGySErxlPxBR3X+nLNATIqpTa4hJ
         YiYMxRnj+dskK+yRotzJHKBYTI+HmzsmQztvTcb4HP7tgGjKes1v5T8Xa01DGZ0Ulgzr
         0FWkLsCHrfGmiKUtOmrPlvvX5/xVLUBvxxDm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3DNXbW3lFA1hCKs/gxZ/BjEHUIQFzhRQhtx/fqIgyBc=;
        b=PhD7RxXXX4qTmVAKEbiJJNuHNNhNjixSOdY0CRje8NMnsBXW+oIbHavQUhS98gNzKb
         +CXF29B5O3HkDCGc1YLASAVjg8epRw6C1mm8jyio71QVVYNBKX/u2EHLePFf5asrhF1k
         Xa6IY3+5qX3gH3PcWd2ZkVK6+A6VWV52YDeuyPeGQ051EzrAHO4cMxoEQjEQnbHF1NJy
         UGM4a7Fn4L2nyev1ZUmuZsDV10Z7HRyl9MPZbcP9vDp176wyHzvV53l8f2Mk4viOAoPn
         Tgg/jdvHdJeZOA77DVIOprk5feP3dYAWRLfsxOVEWQOh36b2QK4JItbvdSSdqKKAYZw8
         9EqQ==
X-Gm-Message-State: AJIora8E6vymWmO3o1XP5vSFete1CpXTOxFYB+SFPlPoBHjusF8Erbt1
        GPqYuvplc3O5+WOJRUcjnbtOhG4AsGsAy70MdSJfEo8e2zA=
X-Google-Smtp-Source: AGRyM1uaILNWXRVoeMUcm0H+vQuc1fsPKLm1FQV+atbEpvFqfIziD8CQ62H5IE6JovY7r64jJnsACtFr7nn30BqoA1A=
X-Received: by 2002:a05:6638:4511:b0:33f:4ccb:3139 with SMTP id
 bs17-20020a056638451100b0033f4ccb3139mr4480399jab.20.1657550860379; Mon, 11
 Jul 2022 07:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAPUE2usKnbvXw5wBLq-w4ZkftAqZdiwQHu51rWi_-Dw8PoC9_Q@mail.gmail.com>
 <20220625222443.2906866-1-gwendal@chromium.org> <CAD=FV=UvSfo82=w5R7R4zhkuj6Z+xffyLe6HRsLzUommTvyWag@mail.gmail.com>
In-Reply-To: <CAD=FV=UvSfo82=w5R7R4zhkuj6Z+xffyLe6HRsLzUommTvyWag@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 11 Jul 2022 16:47:29 +0200
Message-ID: <CAPUE2usLqZdTsQQPMdYT3aU4-QZNuj_+0uJOtZyPxCWCtsm93Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: cros: Register FIFO callback after sensor is registered
To:     Doug Anderson <dianders@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 27, 2022 at 5:41 PM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Sat, Jun 25, 2022 at 3:24 PM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > Instead of registering callback to process sensor events right at
> > initialization time, wait for the sensor to be register in the iio
> > subsystem.
> >
> > Events can come at probe time (in case the kernel rebooted abruptly
> > without switching the sensor off for  instance), and be sent to IIO core
> > before the sensor is fully registered.
> >
> > Reported-by: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> > Changes since v1:
> > - renamed from "iio: cros: Add cros_ec_sensors_core_register"
> > - Call devm_iio_device_register() inside cros_ec_sensors_core_register.
> >
> >  drivers/iio/accel/cros_ec_accel_legacy.c      |  4 +-
> >  .../cros_ec_sensors/cros_ec_lid_angle.c       |  4 +-
> >  .../common/cros_ec_sensors/cros_ec_sensors.c  |  6 +-
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 58 ++++++++++++++-----
> >  drivers/iio/light/cros_ec_light_prox.c        |  6 +-
> >  drivers/iio/pressure/cros_ec_baro.c           |  6 +-
> >  .../linux/iio/common/cros_ec_sensors_core.h   |  7 ++-
> >  7 files changed, 60 insertions(+), 31 deletions(-)
> >
> > diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> > index 1c0171f26e99e..0f403342b1fc0 100644
> > --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> > +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> > @@ -215,7 +215,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
> >                 return -ENOMEM;
> >
> >         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> > -                                       cros_ec_sensors_capture, NULL);
> > +                                       cros_ec_sensors_capture);
> >         if (ret)
> >                 return ret;
> >
> > @@ -235,7 +235,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
> >                 state->sign[CROS_EC_SENSOR_Z] = -1;
> >         }
> >
> > -       return devm_iio_device_register(dev, indio_dev);
> > +       return cros_ec_sensors_core_register(dev, indio_dev, NULL);
>
> In the case where the last argument is NULL then the new
> cros_ec_sensors_core_register() is always equivalent to the old
> devm_iio_device_register(), right? ...but I guess it's more idiomatic
> to always use the cros_ec version, so I'm OK with this.
Yes, it is equivalent.
>
>
> > @@ -372,6 +358,46 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >  }
> >  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
> >
> > +/**
> > + * cros_ec_sensors_core_register() - Register callback to FIFO and IIO when
> > + * sensor is ready.
> > + * It must be called at the end of the sensor probe routine.
> > + * @dev:               device created for the sensor
> > + * @indio_dev:         iio device structure of the device
> > + * @push_data:          function to call when cros_ec_sensorhub receives
> > + *    a sample for that sensor.
> > + *
> > + * Return: 0 on success, -errno on failure.
> > + */
> > +int cros_ec_sensors_core_register(struct device *dev,
> > +                                 struct iio_dev *indio_dev,
> > +                                 cros_ec_sensorhub_push_data_cb_t push_data)
> > +{
> > +       struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
> > +       struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
> > +       struct platform_device *pdev = to_platform_device(dev);
> > +       struct cros_ec_dev *ec = sensor_hub->ec;
> > +       int ret = 0;
>
> nit: don't init "ret" to 0 when you simply assign it right below.
Done
>
>
> > +       ret = devm_iio_device_register(dev, indio_dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO) &&
> > +           push_data != NULL) {
>
> I think the check for push_data should be first so it can short
> circuit and avoid the call to cros_ec_check_features(), right?
>
> In the past I've been yelled at for using "!= NULL" and told that
> thing should simply be "&& push_data". I'll leave it up to you about
> whether it's something that should be changed here.
>
> Also: you can reduce indentation of the function and simply if you just do:
>
> if (!push_data || !cros_ec_check_features(...))
>   return 0;
Done.
>
> -Doug
