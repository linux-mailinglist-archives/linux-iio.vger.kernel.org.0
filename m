Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F78455DCE7
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235053AbiF0Plg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jun 2022 11:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238503AbiF0Plf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Jun 2022 11:41:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD1A1A045
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 08:41:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id u15so19991557ejc.10
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 08:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kfjLdGhSexDPly8hhGteb3RZrx3gdLDiLngp+yfgmtA=;
        b=NsXl7AlqR2pfsCVRgXgqqQMY53PwCluy6Pw33OIkhInuRj6kBIHiZWrcgrSMbk37BR
         irazbdgwO603bJo8fNjG1qnUHYWaCelnYsGSLQ9s9XxGku/wjZ9I1WFgH4Rnbamii2ih
         CuWrK4tcK1xCxQ8mNoCzvL0ptalphmRdIo6SY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kfjLdGhSexDPly8hhGteb3RZrx3gdLDiLngp+yfgmtA=;
        b=UFzpfc4Ebl4SXMAjXT2WyALYGMTpdmIAl5wyL1gMLmnvlrWG+XoF88mjLhCPYf/+PM
         bPZcmaXFYnP9ZAzI9/UYW5k3yRIbN4aRpPpLr/cffJnRVkL0E9Wo2zNXo7MmefKOcUPW
         JL3/EaV56+/n3zL1vM8DktlYp/NE9jGOgjn3Vw1mSocvHs5fVdVAvHxbmjmfSdp6F23G
         WObpIv6ze7SuRACiCaytM+hyeBiKIhXVsehrWG24Pdd0VDaz8jvnbpRPgZ2nJNA8rfjN
         THCAbhFQy3/a8XAEowU3+ih/fxOD+XGMUcHPORD58pReeYGihLo+4y01fE0FKTFL9nts
         OKzQ==
X-Gm-Message-State: AJIora8qhXt2wrHsL2nMfzDgxeQyNz50ayJRRPTutOkCgkBsmm1kigbx
        ogAk/1OFKL1nP71bO/EP6RcJgWW3Go/2b3gI
X-Google-Smtp-Source: AGRyM1vmLCgqpVZwe6Kn/40NtLOBUOrWVO9sUGMatxbOy56k3oVsesTiBfda86DRJHitFNyW6UUeKg==
X-Received: by 2002:a17:907:930:b0:711:da36:62f7 with SMTP id au16-20020a170907093000b00711da3662f7mr13384657ejc.468.1656344491823;
        Mon, 27 Jun 2022 08:41:31 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090638c100b007219c20dcd8sm5149986ejd.196.2022.06.27.08.41.30
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 08:41:31 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id o4so9689165wrh.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Jun 2022 08:41:30 -0700 (PDT)
X-Received: by 2002:adf:d1e9:0:b0:21b:c8f8:3c16 with SMTP id
 g9-20020adfd1e9000000b0021bc8f83c16mr7399317wrd.659.1656344490253; Mon, 27
 Jun 2022 08:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAPUE2usKnbvXw5wBLq-w4ZkftAqZdiwQHu51rWi_-Dw8PoC9_Q@mail.gmail.com>
 <20220625222443.2906866-1-gwendal@chromium.org>
In-Reply-To: <20220625222443.2906866-1-gwendal@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Jun 2022 08:41:18 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UvSfo82=w5R7R4zhkuj6Z+xffyLe6HRsLzUommTvyWag@mail.gmail.com>
Message-ID: <CAD=FV=UvSfo82=w5R7R4zhkuj6Z+xffyLe6HRsLzUommTvyWag@mail.gmail.com>
Subject: Re: [PATCH v2] iio: cros: Register FIFO callback after sensor is registered
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On Sat, Jun 25, 2022 at 3:24 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Instead of registering callback to process sensor events right at
> initialization time, wait for the sensor to be register in the iio
> subsystem.
>
> Events can come at probe time (in case the kernel rebooted abruptly
> without switching the sensor off for  instance), and be sent to IIO core
> before the sensor is fully registered.
>
> Reported-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes since v1:
> - renamed from "iio: cros: Add cros_ec_sensors_core_register"
> - Call devm_iio_device_register() inside cros_ec_sensors_core_register.
>
>  drivers/iio/accel/cros_ec_accel_legacy.c      |  4 +-
>  .../cros_ec_sensors/cros_ec_lid_angle.c       |  4 +-
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |  6 +-
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 58 ++++++++++++++-----
>  drivers/iio/light/cros_ec_light_prox.c        |  6 +-
>  drivers/iio/pressure/cros_ec_baro.c           |  6 +-
>  .../linux/iio/common/cros_ec_sensors_core.h   |  7 ++-
>  7 files changed, 60 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index 1c0171f26e99e..0f403342b1fc0 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -215,7 +215,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> -                                       cros_ec_sensors_capture, NULL);
> +                                       cros_ec_sensors_capture);
>         if (ret)
>                 return ret;
>
> @@ -235,7 +235,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
>                 state->sign[CROS_EC_SENSOR_Z] = -1;
>         }
>
> -       return devm_iio_device_register(dev, indio_dev);
> +       return cros_ec_sensors_core_register(dev, indio_dev, NULL);

In the case where the last argument is NULL then the new
cros_ec_sensors_core_register() is always equivalent to the old
devm_iio_device_register(), right? ...but I guess it's more idiomatic
to always use the cros_ec version, so I'm OK with this.


> @@ -372,6 +358,46 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
>
> +/**
> + * cros_ec_sensors_core_register() - Register callback to FIFO and IIO when
> + * sensor is ready.
> + * It must be called at the end of the sensor probe routine.
> + * @dev:               device created for the sensor
> + * @indio_dev:         iio device structure of the device
> + * @push_data:          function to call when cros_ec_sensorhub receives
> + *    a sample for that sensor.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int cros_ec_sensors_core_register(struct device *dev,
> +                                 struct iio_dev *indio_dev,
> +                                 cros_ec_sensorhub_push_data_cb_t push_data)
> +{
> +       struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
> +       struct cros_ec_sensorhub *sensor_hub = dev_get_drvdata(dev->parent);
> +       struct platform_device *pdev = to_platform_device(dev);
> +       struct cros_ec_dev *ec = sensor_hub->ec;
> +       int ret = 0;

nit: don't init "ret" to 0 when you simply assign it right below.


> +       ret = devm_iio_device_register(dev, indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO) &&
> +           push_data != NULL) {

I think the check for push_data should be first so it can short
circuit and avoid the call to cros_ec_check_features(), right?

In the past I've been yelled at for using "!= NULL" and told that
thing should simply be "&& push_data". I'll leave it up to you about
whether it's something that should be changed here.

Also: you can reduce indentation of the function and simply if you just do:

if (!push_data || !cros_ec_check_features(...))
  return 0;

-Doug
