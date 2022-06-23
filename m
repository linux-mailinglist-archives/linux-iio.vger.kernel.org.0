Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4AA556F9B
	for <lists+linux-iio@lfdr.de>; Thu, 23 Jun 2022 02:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234564AbiFWAo4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Jun 2022 20:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiFWAoz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Jun 2022 20:44:55 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0AF2FFE0
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2022 17:44:53 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id a8-20020a05683012c800b0060c027c8afdso14293135otq.10
        for <linux-iio@vger.kernel.org>; Wed, 22 Jun 2022 17:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=lpAZKwH3a1dAzQ+kA5meAVgTrGUP9e6kKjEmM6YpaRU=;
        b=VB7Rhv4MZjm493aZ7TLWZ7dmpv6t4k3I7q9Zkoz8rB41kveKO0h7szAQ8xo5qF54t9
         hA8LLkqK/C/qeIOx2Rwwx4Ftfu8AcundGK329w9oaOoi0yzI/AraSDAY/23pCEq889BN
         SqYLL17YxdOGnbyWjw7Ag8XXlY948fjdLGSQU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=lpAZKwH3a1dAzQ+kA5meAVgTrGUP9e6kKjEmM6YpaRU=;
        b=kvQ3SMJ5Is0sH6bBb8VaDD2jnd9G3zmhYKXUvSeXgZZ3SDFpgctU40Ai+0wi46vhPH
         WK4Atbe7lmNkUEABfNpY9ZbLHMPZfLLlSxOhm6VNiRBomSIfsATKXT+p2+W3MeXOFprL
         5TfMOHaO0vBIGae3Qd2GOmDaWGAKoA3/rY8KutCdrC++QnjCKvih7AA+cOaOAUejrake
         XHpApbIDVIQilt/PJ0KyYCqjaxJW+AzOqTSf97xvUFtiw75OOgaGqlM5wQYTNlcDVdxp
         MuSAmGunCkdpOdO7F5G1/2uMB4bNbz4Rf5+/VOdOUk1uyL0071IbOAtvs2tV09dtAW7a
         7m+A==
X-Gm-Message-State: AJIora8YhDHbFZLDwhXfAWOv/wCH5pg6SPZr4+2SoqIfwGbDpStX7AYl
        n8NzHRADKzUL5fjbdJoIDVFpxaEwRPyW+Wis0Aod4PbZadk=
X-Google-Smtp-Source: AGRyM1u11bT2D5O44+ST9xbUOOQycGmbmTLjQTChyquQxbqVJDDW22AEcP2mz+g4vQmy68YiWvI5/seZ9v8wxZytcn0=
X-Received: by 2002:a9d:729b:0:b0:60c:21bd:97c0 with SMTP id
 t27-20020a9d729b000000b0060c21bd97c0mr2694982otj.77.1655945092471; Wed, 22
 Jun 2022 17:44:52 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 22 Jun 2022 20:44:51 -0400
MIME-Version: 1.0
In-Reply-To: <20220621182859.459045-1-gwendal@chromium.org>
References: <20220621182859.459045-1-gwendal@chromium.org>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 22 Jun 2022 20:44:51 -0400
Message-ID: <CAE-0n51K25NUGRZNaBQMxvPeMPBzqunnhS28ePkzMs8Jhi2_8g@mail.gmail.com>
Subject: Re: [PATCH] iio: cros: Add cros_ec_sensors_core_register
To:     Gwendal Grignou <gwendal@chromium.org>, dianders@chromium.org,
        jic23@kernel.org
Cc:     linux-iio@vger.kernel.org
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

The subject line could be a little clearer. Perhaps "Wait for sensors to
probe before sending events" or something like that.

Quoting Gwendal Grignou (2022-06-21 11:28:59)
> Instead of registering callback to process sensor events right at
> initialization time, wait for the sensor to be register in the iio
> subsystem.

Please elaborate. A crash is seen if sensor events come in while sensors
are being registered.

>
> Events can come at probe time (in case the kernel rebooted abruptly
> without switching the sensor off for instance).
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Should add

Reported-by: Douglas Anderson <dianders@chromium.org>

and also some sort of Fixes tag.

> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index e5ccedef13a80..5bf5cfb0e746b 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -340,17 +337,6 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>                         if (ret)
>                                 return ret;
>
> -                       ret = cros_ec_sensorhub_register_push_data(
> -                                       sensor_hub, sensor_platform->sensor_num,
> -                                       indio_dev, push_data);
> -                       if (ret)
> -                               return ret;
> -
> -                       ret = devm_add_action_or_reset(
> -                                       dev, cros_ec_sensors_core_clean, pdev);
> -                       if (ret)
> -                               return ret;
> -
>                         /* Timestamp coming from FIFO are in ns since boot. */
>                         ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
>                         if (ret)
> @@ -372,6 +358,39 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
>
> +/**
> + * cros_ec_sensors_core_register() - Register callback to FIFO when sensor is
> + * ready.

Please document 'dev' as well here.

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
> +
> +       if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {

Just curious if this condition is ever false? Or if the case when it is
true is when 'push_data' is cros_ec_sensors_push_data()?

> +               ret = cros_ec_sensorhub_register_push_data(
> +                               sensor_hub, sensor_platform->sensor_num,
> +                               indio_dev, push_data);
> +               if (ret)
> +                       return ret;
> +
> +               ret = devm_add_action_or_reset(
> +                               dev, cros_ec_sensors_core_clean, pdev);
> +       }
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(cros_ec_sensors_core_register);
> +
>  /**
>   * cros_ec_motion_send_host_cmd() - send motion sense host command
>   * @state:             pointer to state information for device
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index 25217279f3507..82f20c738a165 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -139,8 +139,7 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> -                                       cros_ec_sensors_capture,
> -                                       cros_ec_sensors_push_data);
> +                                       cros_ec_sensors_capture);
>         if (ret)
>                 return ret;
>
> @@ -185,7 +184,13 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>
>         state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
>
> -       return devm_iio_device_register(dev, indio_dev);
> +       ret = devm_iio_device_register(dev, indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       /* Ready to receive samples from the EC. */
> +       return cros_ec_sensors_core_register(dev, indio_dev,
> +                                            cros_ec_sensors_push_data);

Would it make sense to add the devm_iio_device_register() call into
cros_ec_sensors_core_register()? Then the caller can't mess up the order
and register the push_data callback before the iio device. And is the
callback ever going to be not cros_ec_sensors_push_data() (or NULL in
case of not motion sense)? Seems like that could be hardcoded into the
function as well.
