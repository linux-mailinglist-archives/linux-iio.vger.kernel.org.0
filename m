Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F97A340501
	for <lists+linux-iio@lfdr.de>; Thu, 18 Mar 2021 12:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhCRL4p (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 18 Mar 2021 07:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhCRL4a (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 18 Mar 2021 07:56:30 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966B7C06174A
        for <linux-iio@vger.kernel.org>; Thu, 18 Mar 2021 04:56:30 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nh23-20020a17090b3657b02900c0d5e235a8so3022488pjb.0
        for <linux-iio@vger.kernel.org>; Thu, 18 Mar 2021 04:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nlqkHlwYfqWvy4GoskZmpJGWIVMn1a4jLBHNjI1K2iE=;
        b=cI5yeSkJgu5VTEvY75HGfJCBLLq04nvuZmvIfJP/+zGvegy/ww3FjeQuDmpGDhag5f
         C0kA4F0/mA+hlVC/KlnaTNzssZoXF4OyT8hXSXwROnnmd5wq4CLzq6qrmzpfxvxKIu5O
         RCM5cVWeYMxIbSgjE8cdRmz/PgtsXwJesSKOei+j+Y7hEf4dCtJdq1OyqMWobDW/swDL
         xnHfaw17dlMd0DQVuSM67cmbIV1sD0ijw5qM59OON4fWECnNbUW6G47uRGzYvqeX7pIK
         UAWk9HqRpIwQy18ic27m6Xe54nbwezUc5y5+HrHYBlW3NDxr0Pc9B8FvWORQg9usF0iK
         rUAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nlqkHlwYfqWvy4GoskZmpJGWIVMn1a4jLBHNjI1K2iE=;
        b=oUS8H/c8ZSRJXYe6ul+lSQjz6nC5PwnmIeGv7GGrgM/VfpO74w3pLXRi2xH2EXdVPq
         GLGu1cg7DnvVTZCX4Zz3nCUBXrnzHMverAjSmJobnxvgVSd3rUdfU2AwuascIhcY2yqb
         BFCnTeODX+CFOfiPfB4SoAlA9ROFCxAWPOIJEDB24/YFl7dGtFqH0oM1rxN5ojo1msNm
         zbQPH2boj121I50UF4L4dM7oMf98NvYYf6rJzmIBkQJH5NG9xf/OuQmWWMxy71QuOZFf
         d4Jr8bWFDec+KZ0Tcufj9VsIIIn8MW+vHu3r43SdLs2kr2ycNRlk5KeId3Ke6doHNA9W
         6aUg==
X-Gm-Message-State: AOAM531VINPDv/vdxL2P9B1zAMDpHqFuSRSifg0rsKL+FyeC9Dx8ggyh
        Y73u/WgQQjt3JrxngsrKUoj19MtomAqhm0++t3c=
X-Google-Smtp-Source: ABdhPJxVu4fxD9ODpgy/kj0GllDmuFkBK1th4BK8VhsN9llUnRxztqJHq+PO9q1UgHoX/6V1vSI/kMAhdcb5+P4pcaY=
X-Received: by 2002:a17:90a:db49:: with SMTP id u9mr4143577pjx.181.1616068590059;
 Thu, 18 Mar 2021 04:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210317204652.2469171-1-gwendal@chromium.org>
In-Reply-To: <20210317204652.2469171-1-gwendal@chromium.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 18 Mar 2021 13:56:13 +0200
Message-ID: <CAHp75Vch5DW-diqQfTe+_YCTv-MUFSpC-EdAR8=3Qw8x5vaiTg@mail.gmail.com>
Subject: Re: [PATCH v6] iio: cros: unify hw fifo attributes without API changes
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        groeck@chromium.org, linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 17, 2021 at 10:47 PM Gwendal Grignou <gwendal@chromium.org> wrote:
>
> Commit 2e2366c2d141 ("iio: cros_ec: unify hw fifo attributes into the core file")
> should be reverted as it set buffer extended attributes at
> the wrong place. However, to revert it will requires to revert more
> commits:

> commit 165aea80e2e2 ("iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()")
> commit 21232b4456ba ("iio: buffer: remove iio_buffer_set_attrs() helper")).
> and we would still have conflict with more recent development.
> commit ee708e6baacd ("iio: buffer: introduce support for attaching more IIO buffers")

You may drop "commit" three times.

> Instead, this commit reverts the first 2 commits without re-adding
> iio_buffer_set_attrs() and set the buffer extended attributes at the
> right place:
>
> 1. Instead of adding has_fw_fifo, deduct it from the configuration:
> - EC must support FIFO (EC_FEATURE_MOTION_SENSE_FIFO) set.
> - sensors send data a regular interval (accelerometer, gyro,
>   magnetomer, barometer, light sensor).
> - "Legacy accelerometer" is only present on EC without FIFO, so we don't
> need to set buffer attributes.
>
> 2. devm_iio_triggered_buffer_setup_ext() does not need to be called when
> EC does not support FIFO, as there is no FIFO to manage.
>
> 3. Use devm_iio_triggered_buffer_setup_ext() when EC has a FIFO to
> specify the buffer extended attributes.

Now it makes a lot of sense to be one commit, thanks!

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Fixes: 2e2366c2d141 ("iio: cros_ec: unify hw fifo attributes into the core file")
> Fixes: 165aea80e2e2 ("iio: cros_ec: use devm_iio_triggered_buffer_setup_ext()")
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Missed tag from Alexandru?

> ---
> Changes since v5:
> Explain why a single patch solution was preferred to multiple commit
> reverts.
>
> Changes since v4:
> Applied on top of commit ("iio: kfifo: add devm_iio_triggered_buffer_setup_ext variant")
> https://patchwork.kernel.org/project/linux-iio/patch/20210311091042.22417-1-aardelean@deviqon.com/
> Remove the slim trigger and use devm_iio_triggered_buffer_setup_ext() instead.
>
> Changes since v3:
> Remove Change-Id.
>
> Changes since v2:
> Remove include of buffer_impl.
> Rebase on top of kernel/git/jic23/iio.git testing branch.
>
> Changes since v1:
> Use a slim trigger when EC supports FIFO, to use
> devm_iio_triggered_buffer_setup_ext().
>
>  drivers/iio/accel/cros_ec_accel_legacy.c      |  2 +-
>  .../cros_ec_sensors/cros_ec_lid_angle.c       |  3 +--
>  .../common/cros_ec_sensors/cros_ec_sensors.c  |  3 +--
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 24 +++++++------------
>  drivers/iio/light/cros_ec_light_prox.c        |  3 +--
>  drivers/iio/pressure/cros_ec_baro.c           |  3 +--
>  .../linux/iio/common/cros_ec_sensors_core.h   |  3 +--
>  7 files changed, 14 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/iio/accel/cros_ec_accel_legacy.c b/drivers/iio/accel/cros_ec_accel_legacy.c
> index 8f1232c38e0d7..b6f3471b62dcf 100644
> --- a/drivers/iio/accel/cros_ec_accel_legacy.c
> +++ b/drivers/iio/accel/cros_ec_accel_legacy.c
> @@ -215,7 +215,7 @@ static int cros_ec_accel_legacy_probe(struct platform_device *pdev)
>                 return -ENOMEM;
>
>         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
> -                                       cros_ec_sensors_capture, NULL, false);
> +                                       cros_ec_sensors_capture, NULL);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> index 752f59037715b..af801e203623e 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_lid_angle.c
> @@ -97,8 +97,7 @@ static int cros_ec_lid_angle_probe(struct platform_device *pdev)
>         if (!indio_dev)
>                 return -ENOMEM;
>
> -       ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL,
> -                                       NULL, false);
> +       ret = cros_ec_sensors_core_init(pdev, indio_dev, false, NULL, NULL);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> index dee1191de7528..376a5b30010ae 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c
> @@ -236,8 +236,7 @@ static int cros_ec_sensors_probe(struct platform_device *pdev)
>
>         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
>                                         cros_ec_sensors_capture,
> -                                       cros_ec_sensors_push_data,
> -                                       true);
> +                                       cros_ec_sensors_push_data);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index f8824afe595e4..094df3ddb2cd0 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -12,6 +12,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/iio/kfifo_buf.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger.h>
>  #include <linux/iio/trigger_consumer.h>
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/kernel.h>
> @@ -240,7 +241,6 @@ static void cros_ec_sensors_core_clean(void *arg)
>   *    for backward compatibility.
>   * @push_data:          function to call when cros_ec_sensorhub receives
>   *    a sample for that sensor.
> - * @has_hw_fifo:       Set true if this device has/uses a HW FIFO
>   *
>   * Return: 0 on success, -errno on failure.
>   */
> @@ -248,8 +248,7 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>                               struct iio_dev *indio_dev,
>                               bool physical_device,
>                               cros_ec_sensors_capture_t trigger_capture,
> -                             cros_ec_sensorhub_push_data_cb_t push_data,
> -                             bool has_hw_fifo)
> +                             cros_ec_sensorhub_push_data_cb_t push_data)
>  {
>         struct device *dev = &pdev->dev;
>         struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
> @@ -334,9 +333,9 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>                          * We can not use trigger here, as events are generated
>                          * as soon as sample_frequency is set.
>                          */
> -                       ret = devm_iio_kfifo_buffer_setup(dev, indio_dev,
> -                                                         INDIO_BUFFER_SOFTWARE,
> -                                                         NULL);
> +                       ret = devm_iio_kfifo_buffer_setup_ext(dev, indio_dev,
> +                                                             INDIO_BUFFER_SOFTWARE, NULL,
> +                                                             cros_ec_sensor_fifo_attributes);
>                         if (ret)
>                                 return ret;
>
> @@ -355,21 +354,14 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>                         ret = iio_device_set_clock(indio_dev, CLOCK_BOOTTIME);
>                         if (ret)
>                                 return ret;
> -               } else {
> -                       const struct attribute **fifo_attrs;
> -
> -                       if (has_hw_fifo)
> -                               fifo_attrs = cros_ec_sensor_fifo_attributes;
> -                       else
> -                               fifo_attrs = NULL;
>
> +               } else {
>                         /*
>                          * The only way to get samples in buffer is to set a
>                          * software trigger (systrig, hrtimer).
>                          */
> -                       ret = devm_iio_triggered_buffer_setup_ext(
> -                                       dev, indio_dev, NULL, trigger_capture,
> -                                       NULL, fifo_attrs);
> +                       ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +                                       NULL, trigger_capture, NULL);
>                         if (ret)
>                                 return ret;
>                 }
> diff --git a/drivers/iio/light/cros_ec_light_prox.c b/drivers/iio/light/cros_ec_light_prox.c
> index 75d6b5fcf2cc4..de472f23d1cba 100644
> --- a/drivers/iio/light/cros_ec_light_prox.c
> +++ b/drivers/iio/light/cros_ec_light_prox.c
> @@ -182,8 +182,7 @@ static int cros_ec_light_prox_probe(struct platform_device *pdev)
>
>         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
>                                         cros_ec_sensors_capture,
> -                                       cros_ec_sensors_push_data,
> -                                       true);
> +                                       cros_ec_sensors_push_data);
>         if (ret)
>                 return ret;
>
> diff --git a/drivers/iio/pressure/cros_ec_baro.c b/drivers/iio/pressure/cros_ec_baro.c
> index aa043cb9ac426..2f882e1094232 100644
> --- a/drivers/iio/pressure/cros_ec_baro.c
> +++ b/drivers/iio/pressure/cros_ec_baro.c
> @@ -139,8 +139,7 @@ static int cros_ec_baro_probe(struct platform_device *pdev)
>
>         ret = cros_ec_sensors_core_init(pdev, indio_dev, true,
>                                         cros_ec_sensors_capture,
> -                                       cros_ec_sensors_push_data,
> -                                       true);
> +                                       cros_ec_sensors_push_data);
>         if (ret)
>                 return ret;
>
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index c9b80be82440f..7ce8a8adad587 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -96,8 +96,7 @@ struct platform_device;
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
>                               struct iio_dev *indio_dev, bool physical_device,
>                               cros_ec_sensors_capture_t trigger_capture,
> -                             cros_ec_sensorhub_push_data_cb_t push_data,
> -                             bool has_hw_fifo);
> +                             cros_ec_sensorhub_push_data_cb_t push_data);
>
>  irqreturn_t cros_ec_sensors_capture(int irq, void *p);
>  int cros_ec_sensors_push_data(struct iio_dev *indio_dev,
> --
> 2.31.0.rc2.261.g7f71774620-goog
>


-- 
With Best Regards,
Andy Shevchenko
