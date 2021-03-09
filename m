Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBE05331E1B
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 05:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbhCIEy7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Mar 2021 23:54:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhCIEya (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 8 Mar 2021 23:54:30 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D08C06174A
        for <linux-iio@vger.kernel.org>; Mon,  8 Mar 2021 20:54:30 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id z9so11059025iln.1
        for <linux-iio@vger.kernel.org>; Mon, 08 Mar 2021 20:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xW/Kl7hWJjQK9xTAkCnW55zwyy2qb8GY0SLpAWgYipE=;
        b=YkSJKYXinptCvG73dun5jOgH+9QLSihXzi9iOZ79PGu489dxWuo2ptb+U2H8uJiPBH
         goWEvob8mZra0plh7v9kOXmSrBT9A8f43qIr9w4Mgwnf2zD/g9puUs3IyCa8/nyRoDTT
         aXJMCMweesWRKXxANIhA9Ytw7umBl30V953jQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xW/Kl7hWJjQK9xTAkCnW55zwyy2qb8GY0SLpAWgYipE=;
        b=SdThHCKli/fKfgyJi6tmOTp/XOPQPUdWDuWKLu8tKMAWHPv9K/gJYej29VVjerEMUu
         DqbBt1EVZLZ3fMBTHHs7Drg6SSTA9Qf5x39P92oE4+Itt962SjUKJoV8iUo01wOv7/6v
         aXk19+HH3gUSigyNatXF16Wi5Kwip8CCqO1zfFRIPm/y1ViYRj945argPNFmOFEpsMvc
         BVCdQBKXylr4NA8dsQrz4jOIAM/L+fUrs82Y96HMsPwG1zyuG2aWDUu8xjxmKbOjXCVa
         FNPxkC59mPdKHaRJqq94cyICC6tc3XqdUagQj8waHD5Ab6YG6VgLn6lprH9xBTCiGrqM
         CuYw==
X-Gm-Message-State: AOAM531TjkJp3dFtwnfr2oO3RWQdzM4ApOF2PaMca+DMkNseBu78HTf/
        RnJCpzszmDCwGoyc3sXO6PdtaCn4596AX0eXLc1u8/gc2RkiuQ==
X-Google-Smtp-Source: ABdhPJzmQtGd4Utt2svprktd4TMVJxGmhy9BUmdd42ZqMNvaOM4vXKUyQI0z0sCSjZE3oZ1VnCkVevBn54YhNWoj/K8=
X-Received: by 2002:a05:6e02:1be6:: with SMTP id y6mr22010701ilv.145.1615265669765;
 Mon, 08 Mar 2021 20:54:29 -0800 (PST)
MIME-Version: 1.0
References: <20210308010922.765394-1-gwendal@chromium.org> <CA+U=DsoVs630_jAyBJqtWYDZ+nPSSX1oVzMgxMQgtbViA9Cnog@mail.gmail.com>
In-Reply-To: <CA+U=DsoVs630_jAyBJqtWYDZ+nPSSX1oVzMgxMQgtbViA9Cnog@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Mon, 8 Mar 2021 20:54:17 -0800
Message-ID: <CAPUE2uv+WyTdwi3mCLMx03onX5NBbJ0+Qiw2moh3FFUa6JaLoA@mail.gmail.com>
Subject: Re: [PATCH] iio: cros: unify hw fifo attributes without API changes
To:     Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Guenter Roeck <groeck@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 8, 2021 at 1:19 AM Alexandru Ardelean
<ardeleanalex@gmail.com> wrote:
>
> On Mon, Mar 8, 2021 at 10:34 AM Gwendal Grignou <gwendal@chromium.org> wrote:
> >
> > fixes commit 2e2366c2d141 ("iio: cros_ec: unify hw fifo attributes into the core file")
> > fixes commit 165aea80e2e2 ("iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()")
> >
> > 1. Instead of adding has_fw_fifo, deduct it from the configuration:
> > - EC must support FIFO (EC_FEATURE_MOTION_SENSE_FIFO) set.
> > - sensors send data a regular interval (accelerometer, gyro,
> >   magnetomer, barometer, light sensor).
> > - "Legacy accelerometer" is only present on EC without FIFO, so we don't
> > need to set buffer attributes.
> >
> > 2. devm_iio_triggered_buffer_setup_ext() does not need to be called.
> > Only when the EC support FIFO we set the buffer attributes directly to set
> > timeout and watermark.
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/iio/accel/cros_ec_accel_legacy.c      |  2 +-
> >  .../cros_ec_sensors/cros_ec_lid_angle.c       |  3 +--
> >  .../common/cros_ec_sensors/cros_ec_sensors.c  |  3 +--
> >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 19 +++++++------------
> >  drivers/iio/light/cros_ec_light_prox.c        |  3 +--
> >  drivers/iio/pressure/cros_ec_baro.c           |  3 +--
> >  .../linux/iio/common/cros_ec_sensors_core.h   |  3 +--
> >  7 files changed, 13 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> > index 8f1232c38e0d7..b6f3471b62dcf 100644
> > --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> > +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> > @@ -215,7 +215,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
> >                 return -ENOMEM;
> >
> >         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> > -                                       cros_ec_sensors_capture, NULL, false);
> > +                                       cros_ec_sensors_capture, NULL);
> >         if (ret)
> >                 return ret;
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > index 752f59037715b..af801e203623e 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> > @@ -97,8 +97,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
> >         if (!indio_dev)
> >                 return -ENOMEM;
> >
> > -       ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL,
> > -                                       NULL, false);
> > +       ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL, NULL);
> >         if (ret)
> >                 return ret;
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > index dee1191de7528..376a5b30010ae 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> > @@ -236,8 +236,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
> >
> >         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> >                                         cros_ec_sensors_capture,
> > -                                       cros_ec_sensors_push_data,
> > -                                       true);
> > +                                       cros_ec_sensors_push_data);
> >         if (ret)
> >                 return ret;
> >
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index c833ec0ef2147..1926f5719b2d4 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> >  #include <linux/iio/buffer.h>
> > +#include <linux/iio/buffer_impl.h>
>
> buffer_impl.h should not need to be included in drivers;
> in should be included in buffer implementations like kfifo,
> dma-buffer, and others
I added the include file to be able to access buffer->attrs. I agree
it is not supposed to be called by iio driver themselves.


>
> >  #include <linux/iio/common/cros_ec_sensors_core.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/kfifo_buf.h>
> > @@ -240,7 +241,6 @@ static void cros_ec_sensors_core_clean(void *arg)
> >   *    for backward compatibility.
> >   * @push_data:          function to call when cros_ec_sensorhub receives
> >   *    a sample for that sensor.
> > - * @has_hw_fifo:       Set true if this device has/uses a HW FIFO
> >   *
> >   * Return: 0 on success, -errno on failure.
> >   */
> > @@ -248,8 +248,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >                               struct iio_dev *indio_dev,
> >                               bool physical_device,
> >                               cros_ec_sensors_capture_t trigger_capture,
> > -                             cros_ec_sensorhub_push_data_cb_t push_data,
> > -                             bool has_hw_fifo)
> > +                             cros_ec_sensorhub_push_data_cb_t push_data)
> >  {
> >         struct device *dev = &pdev->dev;
> >         struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
> > @@ -358,21 +357,17 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >                         ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
> >                         if (ret)
> >                                 return ret;
> > -               } else {
> > -                       const struct attribute **fifo_attrs;
> > -
> > -                       if (has_hw_fifo)
> > -                               fifo_attrs = cros_ec_sensor_fifo_attributes;
> > -                       else
> > -                               fifo_attrs = NULL;
> >
> > +                       /* Set attributes to control EC FIFO directly. */
> > +                       indio_dev->buffer->attrs = cros_ec_sensor_fifo_attributes;
>
> accessing 'indio_dev->buffer' directly will be discouraged, because
> the idea [moving forward] is to support more than one IIO buffer per
> IIO device;
> the idea of devm_iio_triggered_buffer_setup_ext() is to pass the
> 'cros_ec_sensor_fifo_attributes' to the IIO buffer, without needing to
> dig it from the IIO device;

What I can do using the existing iio API is to create a "slim" trigger
that does not do much like hid sensor stack does at
hid_sensor_setup_trigger() while callbacks callbacks.send_event and
callbacks.capture_sample are doing the real work.
But once I have a trigger, I can call
devm_iio_triggered_buffer_setup_ext and set the fifo attributes.

Gwendal.
>
> maybe a new method will be needed to access each IIO buffer of the IIO device;
> but when that happens, accessing a buffer with  'indio_dev->buffer'
> and iio_device_get_buffer(indio_dev, 0 [or 1]) will look a bit
> confusing (or at least duplicate)
>
> > +               } else {
> >                         /*
> >                          * The only way to get samples in buffer is to set a
> >                          * software trigger (systrig, hrtimer).
> >                          */
> > -                       ret = devm_iio_triggered_buffer_setup_ext(
> > +                       ret = devm_iio_triggered_buffer_setup(
> >                                         dev, indio_dev, NULL, trigger_capture,
> > -                                       NULL, fifo_attrs);
> > +                                       NULL);
> >                         if (ret)
> >                                 return ret;
> >                 }
> > diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> > index 75d6b5fcf2cc4..de472f23d1cba 100644
> > --- a/drivers/iio/light/cros_ec_light_prox.c
> > +++ b/drivers/iio/light/cros_ec_light_prox.c
> > @@ -182,8 +182,7 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
> >
> >         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> >                                         cros_ec_sensors_capture,
> > -                                       cros_ec_sensors_push_data,
> > -                                       true);
> > +                                       cros_ec_sensors_push_data);
> >         if (ret)
> >                 return ret;
> >
> > diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> > index aa043cb9ac426..2f882e1094232 100644
> > --- a/drivers/iio/pressure/cros_ec_baro.c
> > +++ b/drivers/iio/pressure/cros_ec_baro.c
> > @@ -139,8 +139,7 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
> >
> >         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> >                                         cros_ec_sensors_capture,
> > -                                       cros_ec_sensors_push_data,
> > -                                       true);
> > +                                       cros_ec_sensors_push_data);
> >         if (ret)
> >                 return ret;
> >
> > diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> > index c9b80be82440f..7ce8a8adad587 100644
> > --- a/include/linux/iio/common/cros_ec_sensors_core.h
> > +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> > @@ -96,8 +96,7 @@ struct platform_device;
> >  int cros_ec_sensors_core_init(struct platform_device *pdev,
> >                               struct iio_dev *indio_dev, bool physical_device,
> >                               cros_ec_sensors_capture_t trigger_capture,
> > -                             cros_ec_sensorhub_push_data_cb_t push_data,
> > -                             bool has_hw_fifo);
> > +                             cros_ec_sensorhub_push_data_cb_t push_data);
> >
> >  irqreturn_t cros_ec_sensors_capture(int irq, void *p);
> >  int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
> > --
> > 2.30.1.766.gb4fecdf3b7-goog
> >
