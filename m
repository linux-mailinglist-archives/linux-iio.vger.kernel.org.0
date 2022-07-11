Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6119570A19
	for <lists+linux-iio@lfdr.de>; Mon, 11 Jul 2022 20:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiGKSp4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Jul 2022 14:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKSpz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Jul 2022 14:45:55 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7720F1F2EB
        for <linux-iio@vger.kernel.org>; Mon, 11 Jul 2022 11:45:51 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id h23so10290529ejj.12
        for <linux-iio@vger.kernel.org>; Mon, 11 Jul 2022 11:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1RsWff47LxhudZHFngID0hDulVvllnH8BZICMjZYZU=;
        b=DyV4IVBQMxLl/6ko/Tfj8FZmTmYn9Zs9XYRSEH7bEq3t2dtHUBzWmOFY/HCJ3knUkt
         BX4BOQ4EHVQGXdCzGuCGLKefX3JXNpf+EJP5Cy7rACBdOjHlBFVmQAfc/MmvMBB+SIpd
         GVftrGWG43F+9XCDA4P4DvuL/floKuPaWjYaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1RsWff47LxhudZHFngID0hDulVvllnH8BZICMjZYZU=;
        b=dxv4hoBQg/Geex2LYmJ3vnGcDVWEzypkmH8aFkqRgQBoILcYiaReZh97G5MhzD3cdQ
         e3QfJ4RNlyghd/w+QUiQagcRqu3sH18HkZyUek51zY1hmvcFd+nBTJEcvkkHm3RLrDzt
         wbUdK+EpUTZq0GtJiYhBFRqRw9bBgjdLGa59KsI3AM2W7UXxJ+aRtU9EzcVtt/AVbzFJ
         TLHW8zVRFcDWB5Sjv/Gnq4ngz9xF2CEupCvdOmTgrlx+qYsJoXdbGYMPD/Z0SEOOdGiJ
         qwfs0Cl90L/SFEaQ3UB2622JHM9G98Fa44rX9peeSXhO9eSriYiW+S/bPmd6l0YXKVTu
         8vPw==
X-Gm-Message-State: AJIora/HyxnkjbgJPxCfCSymSaWaHiHJnoBl3NGL7VR4NWx6HsbLoVsF
        3Em+2SKeifLCNkclwuYzEPXX2NwN6cOsQ1Lav4Q=
X-Google-Smtp-Source: AGRyM1tb9QOia8yu67LZSR1CtrqsvUU4ERwDwWCs1a/+/qku2t6/P+Bfceh7PrWrJaLMx0OuFMC3fw==
X-Received: by 2002:a17:906:8a49:b0:72b:3b8d:31c3 with SMTP id gx9-20020a1709068a4900b0072b3b8d31c3mr12836785ejc.279.1657565149784;
        Mon, 11 Jul 2022 11:45:49 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id cb1-20020a0564020b6100b0043a6dc3c4b0sm4762968edb.41.2022.07.11.11.45.49
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 11:45:49 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id r129-20020a1c4487000000b003a2d053adcbso5486073wma.4
        for <linux-iio@vger.kernel.org>; Mon, 11 Jul 2022 11:45:49 -0700 (PDT)
X-Received: by 2002:a05:600c:285:b0:3a2:e5fd:84eb with SMTP id
 5-20020a05600c028500b003a2e5fd84ebmr9054023wmk.151.1657565148811; Mon, 11 Jul
 2022 11:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220711144716.642617-1-gwendal@chromium.org>
In-Reply-To: <20220711144716.642617-1-gwendal@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 11:45:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VEiVgXSC=vx5vB3kEuL2XCQyuaAxNvDHig-PjOfANHag@mail.gmail.com>
Message-ID: <CAD=FV=VEiVgXSC=vx5vB3kEuL2XCQyuaAxNvDHig-PjOfANHag@mail.gmail.com>
Subject: Re: [PATCH v3] iio: cros: Register FIFO callback after sensor is registered
To:     Gwendal Grignou <gwendal@chromium.org>
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

Hi,

On Mon, Jul 11, 2022 at 7:47 AM Gwendal Grignou <gwendal@chromium.org> wrote:
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
> Changes since v2:
> - Do not compare pointer with NULL,
> - Invert logic to reduce indentation.
> - Do not set local variable just before use.
>
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
>  }
>
>  static struct platform_driver cros_ec_accel_platform_driver = {
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> index 9f780fafaed9f..119acb078af3b 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> @@ -98,7 +98,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
>         if (!indio_dev)
>                 return -ENOMEM;
>
> -       ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL, NULL);
> +       ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL);
>         if (ret)
>                 return ret;
>
> @@ -114,7 +114,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> -       return devm_iio_device_register(dev, indio_dev);
> +       return cros_ec_sensors_core_register(dev, indio_dev, NULL);
>  }
>
>  static const struct platform_device_id cros_ec_lid_angle_ids[] = {
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index 61e07a7bb1995..66153b1850f10 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -236,8 +236,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> -                                       cros_ec_sensors_capture,
> -                                       cros_ec_sensors_push_data);
> +                                       cros_ec_sensors_capture);
>         if (ret)
>                 return ret;
>
> @@ -298,7 +297,8 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>         else
>                 state->core.read_ec_sensors_data = cros_ec_sensors_read_cmd;
>
> -       return devm_iio_device_register(dev, indio_dev);
> +       return cros_ec_sensors_core_register(dev, indio_dev,
> +                       cros_ec_sensors_push_data);

Probably not worth spinning for, but now that the indentation was been
reduced (compared to v2) the above call doesn't need to be split
across 2 lines.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
