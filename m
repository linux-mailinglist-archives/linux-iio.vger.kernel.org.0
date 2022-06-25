Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6263C55ACE5
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jun 2022 00:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233310AbiFYWWW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 25 Jun 2022 18:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiFYWWW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 25 Jun 2022 18:22:22 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C5913CC9
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 15:22:21 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id p9so3438720ilj.7
        for <linux-iio@vger.kernel.org>; Sat, 25 Jun 2022 15:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NVhDKiM0nOIXwoLlSCsD8vo45IR/cgpobpBsKgECPtE=;
        b=IYCLafCvqObJZ6OY2sQSx6mE1clTpoxh32pfUCEM5nFIPxnhDR1GJ1vNhh51LCtNv5
         mvtpSZ1MHgTzJVyyptETH5wDdlJgPxiCQW6hSh3vN7zfXdnqOzvJz40fdYoxxG4ssMsL
         o1/JbHSOQM9t4bmD0iLchMYqReqahVuZ5QKuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NVhDKiM0nOIXwoLlSCsD8vo45IR/cgpobpBsKgECPtE=;
        b=KqhfRlykPDGpru03AQASEprrOE1oOwZ7bcdQTfMGBKcZQwpWnuQ4FjUqHVkO7NgHRP
         rgcxB7oOBpak6lhs0c5OwDBq2lay+w9U2i019lq7OmiNjUJ2GLS5ShD5w6+uRIbSEUyF
         78p5CoiBkU7gOcsQm2QL6Ck1tVg1zIbYatM5EfzYzTihZGg0gZr6zhTJN6gUlGy3kw+l
         7ySPou+OKD/f9j0zt+OkuIJ3Znfd+oP3AUwoTqjFdukw4bnPbh+utxkEm8ejSaAqwFcm
         1OqyvbGmP7P2IJt23hzzo7T2uVHJuEgj0xkUoQHVJBoRuvmxF4zdLNUIsghO0FdBZvHk
         Ip0g==
X-Gm-Message-State: AJIora9gO67UcCzpD71kNgK6lYoyVqBiNHOA9abEbUm6tlR5al47IqXi
        0wAEbJWgYHcR2EvnY3Ec3pefcMFCnIg23nbadFR/Xg==
X-Google-Smtp-Source: AGRyM1sjrtoHtXyMXsnv1MT2lNG0CFLp87bY/92ZzbzW9SBjc9tdZ4qKNX9S55UiR2xbUhPxql5W4UxuUfljlL9SqP8=
X-Received: by 2002:a05:6e02:1bc6:b0:2d3:dba7:f626 with SMTP id
 x6-20020a056e021bc600b002d3dba7f626mr3113747ilv.299.1656195740397; Sat, 25
 Jun 2022 15:22:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220621182859.459045-1-gwendal@chromium.org> <CAE-0n51K25NUGRZNaBQMxvPeMPBzqunnhS28ePkzMs8Jhi2_8g@mail.gmail.com>
In-Reply-To: <CAE-0n51K25NUGRZNaBQMxvPeMPBzqunnhS28ePkzMs8Jhi2_8g@mail.gmail.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Sat, 25 Jun 2022 15:22:08 -0700
Message-ID: <CAPUE2usKnbvXw5wBLq-w4ZkftAqZdiwQHu51rWi_-Dw8PoC9_Q@mail.gmail.com>
Subject: Re: [PATCH] iio: cros: Add cros_ec_sensors_core_register
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     dianders@chromium.org, jic23@kernel.org, linux-iio@vger.kernel.org
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

On Wed, Jun 22, 2022 at 5:44 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> The subject line could be a little clearer. Perhaps "Wait for sensors to
> probe before sending events" or something like that.
>
> Quoting Gwendal Grignou (2022-06-21 11:28:59)
> > Instead of registering callback to process sensor events right at
> > initialization time, wait for the sensor to be register in the iio
> > subsystem.
>
> Please elaborate. A crash is seen if sensor events come in while sensors
> are being registered.
The crash only happens to a sensor that is not upstream yet. (the
channels are allocated at probe time and we get a NULL dereference).
For existing sensors, the channels are allocated at compilation time,
so the kernel does not crash. We do send data to IIO core while it is
still initializing the sensor.
>
> >
> > Events can come at probe time (in case the kernel rebooted abruptly
> > without switching the sensor off for instance).
> >
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
>
> Should add
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
Done in v2.
>
> and also some sort of Fixes tag.
Done in v2.
>
> > diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > index e5ccedef13a80..5bf5cfb0e746b 100644
> > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > @@ -340,17 +337,6 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >                         if (ret)
> >                                 return ret;
> >
> > -                       ret = cros_ec_sensorhub_register_push_data(
> > -                                       sensor_hub, sensor_platform->sensor_num,
> > -                                       indio_dev, push_data);
> > -                       if (ret)
> > -                               return ret;
> > -
> > -                       ret = devm_add_action_or_reset(
> > -                                       dev, cros_ec_sensors_core_clean, pdev);
> > -                       if (ret)
> > -                               return ret;
> > -
> >                         /* Timestamp coming from FIFO are in ns since boot. */
> >                         ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
> >                         if (ret)
> > @@ -372,6 +358,39 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
> >  }
> >  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
> >
> > +/**
> > + * cros_ec_sensors_core_register() - Register callback to FIFO when sensor is
> > + * ready.
>
> Please document 'dev' as well here.
Done in v2.
>
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
> > +
> > +       if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
>
> Just curious if this condition is ever false? Or if the case when it is
> true is when 'push_data' is cros_ec_sensors_push_data()?
It is false on older chromebooks, where sensor data needs to be polled
by the host.
>
> > +               ret = cros_ec_sensorhub_register_push_data(
> > +                               sensor_hub, sensor_platform->sensor_num,
> > +                               indio_dev, push_data);
> > +               if (ret)
> > +                       return ret;
> > +
> > +               ret = devm_add_action_or_reset(
> > +                               dev, cros_ec_sensors_core_clean, pdev);
> > +       }
> > +       return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(cros_ec_sensors_core_register);
> > +
> >  /**
> >   * cros_ec_motion_send_host_cmd() - send motion sense host command
> >   * @state:             pointer to state information for device
> > diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> > index 25217279f3507..82f20c738a165 100644
> > --- a/drivers/iio/pressure/cros_ec_baro.c
> > +++ b/drivers/iio/pressure/cros_ec_baro.c
> > @@ -139,8 +139,7 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
> >                 return -ENOMEM;
> >
> >         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> > -                                       cros_ec_sensors_capture,
> > -                                       cros_ec_sensors_push_data);
> > +                                       cros_ec_sensors_capture);
> >         if (ret)
> >                 return ret;
> >
> > @@ -185,7 +184,13 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
> >
> >         state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
> >
> > -       return devm_iio_device_register(dev, indio_dev);
> > +       ret = devm_iio_device_register(dev, indio_dev);
> > +       if (ret)
> > +               return ret;
> > +
> > +       /* Ready to receive samples from the EC. */
> > +       return cros_ec_sensors_core_register(dev, indio_dev,
> > +                                            cros_ec_sensors_push_data);
>
> Would it make sense to add the devm_iio_device_register() call into
> cros_ec_sensors_core_register()? Then the caller can't mess up the order
> and register the push_data callback before the iio device.
Good idea, done in v2.
> And is the
> callback ever going to be not cros_ec_sensors_push_data() (or NULL in
> case of not motion sense)? Seems like that could be hardcoded into the
> function as well.
The callback can be different from the default cros_ec_sensors_push_data().
