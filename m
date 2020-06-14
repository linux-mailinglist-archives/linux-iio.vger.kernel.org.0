Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C66F61F8810
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jun 2020 11:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgFNJYf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jun 2020 05:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbgFNJYf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jun 2020 05:24:35 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B749C03E969
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2020 02:24:34 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k6so610565pll.9
        for <linux-iio@vger.kernel.org>; Sun, 14 Jun 2020 02:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NuLdVnbm7jtFWsmH68W1aCKkBXWtM759Eei1cAk7mmQ=;
        b=Hy7M1VfUp/wMRZUfXz42PEWGDWhp530tZ1eAZ+b9XolaPLgAkhrT0cMN4Gni/4zz/G
         OmkheSdor926UCFnPuqw/3LDk2hHDxFt6RCX4lkn7WoloqP/zBveKmsTnDqsQcANhRcg
         Kf2NfzAdVLPl/Hy/IgSYKHpk4Em4EGvfbVpAyPjxdD47y/jQcbMEYUsOnzKQO6gxNz4w
         iedUSDucoEXQW3kRsEauincoqGFR/xUSTe/u4RJOiyKQ2rpn7wZOEcX6wTXsn5Z/2+f9
         W4g3ZIyEyD9wdYeKgYMHsnX8DdBx0RFFNqqHqaK0Y1zOZPlgcQ5T2nCa6TVCahWLQt3I
         YISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NuLdVnbm7jtFWsmH68W1aCKkBXWtM759Eei1cAk7mmQ=;
        b=D1/BAA/118HxwWpMBQkKVSUJJgJQ7I12317JhdD5kUBHdVqKHGng/oTM2HEPVPzqVH
         jrn9pX0C83Fh04dI42tqCXqIBl7Vo926bLpvJw0nwvAv2yZ200UkRKPH/o5jwPE1m81L
         U2zzFHQ25xbPI4EFV1jHk2JyfDuuF391TqtYNaVHrrcdLR+DTlifZ0Gu5pPiTMy1gD8B
         UytLt/pA2CgJiKrS46R8gGQ/Xr2pL69AkmRFcOGDZMNT4HahOKBHFvhtWkU7vOplnDTP
         Gz3dExmDYS0CVq4MI2MFThm3nMuom0gKlqyq1azGHuuVtp9VHDIZxPn2HKuAKgS0wBYL
         Q8Cw==
X-Gm-Message-State: AOAM531yqbmTkglDOupkLHaoEo/aAuTp4/UPxXmDvHPSLelF7/+wt8sm
        U3ME3wnWh81DP+zW+3wHVi59jrZA+fRoaDJSmZV3iyZNuiY=
X-Google-Smtp-Source: ABdhPJzvnb8GabRZj3rM2wC3IQb1KShwjV3o9WWQDlbkVJzxV4u1rbxBBbEwKyV2MqBHvjmf1oPCqODtFwTNkGo2VVU=
X-Received: by 2002:a17:90a:b30d:: with SMTP id d13mr6727647pjr.181.1592126672708;
 Sun, 14 Jun 2020 02:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200613121715.11898-1-lars@metafoo.de>
In-Reply-To: <20200613121715.11898-1-lars@metafoo.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 14 Jun 2020 12:24:16 +0300
Message-ID: <CAHp75VfyL5tPR7GOH6ih+24ExfQjmVWhLdwXoBLUpXBNCP9Gog@mail.gmail.com>
Subject: Re: [PATCH] iio: Remove superfluous of_node assignments
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Jun 13, 2020 at 3:18 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> If a driver does not assign an of_node to a IIO device to IIO core will
> automatically assign the of_node of the parent device. This automatic
> assignment is done in the iio_device_register() function.
>
> There is a fair amount of drivers that currently manually assign the
> of_node of the IIO device. All but 4 of them can make use of the automatic
> assignment though.
>
> The exceptions are:
>  * mxs-lradc-adc: Which uses the of_node of the parent of the parent.
>  * stm32-dfsdm-adc, stm32-adc and stm32-dac: Which reference the of_node
>    assigned to the IIO device before iio_device_register() is called.
>
> All other drivers are updated to use automatic assignment. This reduces
> the amount of boilerplate code involved in setting up the IIO device.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

I consider it an extremely right step to do. Actually we need to
switch to fwnode / device property API at the end.

> The patch has mostly been auto-generated with the following semantic patch
>
> // <smpl>
> @exists@
> expression indio_dev;
> expression parent;
> @@
> indio_dev = \(devm_iio_device_alloc\|iio_device_alloc\)(&parent, ...)
> ...
> -indio_dev->dev.of_node = parent.of_node;
>
> @exists@
> expression indio_dev;
> expression parent;
> @@
> indio_dev = \(devm_iio_device_alloc\|iio_device_alloc\)(parent, ...)
> ...
> -indio_dev->dev.of_node = parent->of_node;
> // </smpl>
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> Inspired by Alex's series of remove manual parent assignment
> ---
>  drivers/iio/accel/ssp_accel_sensor.c      | 1 -
>  drivers/iio/adc/ab8500-gpadc.c            | 1 -
>  drivers/iio/adc/ad7266.c                  | 1 -
>  drivers/iio/adc/ad7291.c                  | 1 -
>  drivers/iio/adc/ad7298.c                  | 1 -
>  drivers/iio/adc/ad7476.c                  | 1 -
>  drivers/iio/adc/ad7791.c                  | 1 -
>  drivers/iio/adc/ad7793.c                  | 1 -
>  drivers/iio/adc/ad7887.c                  | 1 -
>  drivers/iio/adc/ad7923.c                  | 1 -
>  drivers/iio/adc/ad7949.c                  | 1 -
>  drivers/iio/adc/ad799x.c                  | 1 -
>  drivers/iio/adc/axp20x_adc.c              | 1 -
>  drivers/iio/adc/bcm_iproc_adc.c           | 1 -
>  drivers/iio/adc/cpcap-adc.c               | 1 -
>  drivers/iio/adc/da9150-gpadc.c            | 1 -
>  drivers/iio/adc/envelope-detector.c       | 1 -
>  drivers/iio/adc/exynos_adc.c              | 1 -
>  drivers/iio/adc/hi8435.c                  | 1 -
>  drivers/iio/adc/ina2xx-adc.c              | 1 -
>  drivers/iio/adc/lp8788_adc.c              | 1 -
>  drivers/iio/adc/max1027.c                 | 1 -
>  drivers/iio/adc/max11100.c                | 1 -
>  drivers/iio/adc/max1363.c                 | 2 --
>  drivers/iio/adc/max9611.c                 | 1 -
>  drivers/iio/adc/mcp320x.c                 | 1 -
>  drivers/iio/adc/mcp3422.c                 | 1 -
>  drivers/iio/adc/mcp3911.c                 | 1 -
>  drivers/iio/adc/meson_saradc.c            | 1 -
>  drivers/iio/adc/nau7802.c                 | 1 -
>  drivers/iio/adc/qcom-pm8xxx-xoadc.c       | 1 -
>  drivers/iio/adc/qcom-spmi-adc5.c          | 1 -
>  drivers/iio/adc/qcom-spmi-iadc.c          | 1 -
>  drivers/iio/adc/qcom-spmi-vadc.c          | 1 -
>  drivers/iio/adc/rcar-gyroadc.c            | 1 -
>  drivers/iio/adc/rockchip_saradc.c         | 1 -
>  drivers/iio/adc/sd_adc_modulator.c        | 1 -
>  drivers/iio/adc/sun4i-gpadc-iio.c         | 1 -
>  drivers/iio/adc/ti-adc081c.c              | 1 -
>  drivers/iio/adc/ti-adc0832.c              | 1 -
>  drivers/iio/adc/ti-adc084s021.c           | 1 -
>  drivers/iio/adc/ti-adc128s052.c           | 1 -
>  drivers/iio/adc/ti-adc161s626.c           | 1 -
>  drivers/iio/adc/ti-ads1015.c              | 1 -
>  drivers/iio/adc/ti-ads124s08.c            | 1 -
>  drivers/iio/adc/ti-ads8344.c              | 1 -
>  drivers/iio/adc/ti-ads8688.c              | 1 -
>  drivers/iio/adc/twl4030-madc.c            | 1 -
>  drivers/iio/adc/vf610_adc.c               | 1 -
>  drivers/iio/adc/xilinx-xadc-core.c        | 1 -
>  drivers/iio/dac/ds4424.c                  | 1 -
>  drivers/iio/dac/ti-dac5571.c              | 1 -
>  drivers/iio/dac/ti-dac7311.c              | 1 -
>  drivers/iio/dac/vf610_dac.c               | 1 -
>  drivers/iio/pressure/dlhl60d.c            | 1 -
>  drivers/iio/temperature/max31856.c        | 1 -
>  drivers/iio/trigger/stm32-timer-trigger.c | 1 -
>  57 files changed, 58 deletions(-)
>
> diff --git a/drivers/iio/accel/ssp_accel_sensor.c b/drivers/iio/accel/ssp_accel_sensor.c
> index 3102b507e22a..474477e91b5e 100644
> --- a/drivers/iio/accel/ssp_accel_sensor.c
> +++ b/drivers/iio/accel/ssp_accel_sensor.c
> @@ -108,7 +108,6 @@ static int ssp_accel_probe(struct platform_device *pdev)
>         spd->type = SSP_ACCELEROMETER_SENSOR;
>
>         indio_dev->name = ssp_accel_device_name;
> -       indio_dev->dev.of_node = pdev->dev.of_node;
>         indio_dev->info = &ssp_accel_iio_info;
>         indio_dev->modes = INDIO_BUFFER_SOFTWARE;
>         indio_dev->channels = ssp_acc_channels;
> diff --git a/drivers/iio/adc/ab8500-gpadc.c b/drivers/iio/adc/ab8500-gpadc.c
> index b264f88cf9d9..7fdc5d2d1d35 100644
> --- a/drivers/iio/adc/ab8500-gpadc.c
> +++ b/drivers/iio/adc/ab8500-gpadc.c
> @@ -1163,7 +1163,6 @@ static int ab8500_gpadc_probe(struct platform_device *pdev)
>
>         pm_runtime_put(dev);
>
> -       indio_dev->dev.of_node = np;
>         indio_dev->name = "ab8500-gpadc";
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &ab8500_gpadc_info;
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index 715d39b200df..3dc15ec04f66 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -437,7 +437,6 @@ static int ad7266_probe(struct spi_device *spi)
>         spi_set_drvdata(spi, indio_dev);
>         st->spi = spi;
>
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &ad7266_info;
> diff --git a/drivers/iio/adc/ad7291.c b/drivers/iio/adc/ad7291.c
> index dbba62ad5e16..62fde2aad282 100644
> --- a/drivers/iio/adc/ad7291.c
> +++ b/drivers/iio/adc/ad7291.c
> @@ -502,7 +502,6 @@ static int ad7291_probe(struct i2c_client *client,
>         indio_dev->channels = ad7291_channels;
>         indio_dev->num_channels = ARRAY_SIZE(ad7291_channels);
>
> -       indio_dev->dev.of_node = client->dev.of_node;
>         indio_dev->info = &ad7291_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
> diff --git a/drivers/iio/adc/ad7298.c b/drivers/iio/adc/ad7298.c
> index 26768b15c0de..733fb1256456 100644
> --- a/drivers/iio/adc/ad7298.c
> +++ b/drivers/iio/adc/ad7298.c
> @@ -312,7 +312,6 @@ static int ad7298_probe(struct spi_device *spi)
>         st->spi = spi;
>
>         indio_dev->name = spi_get_device_id(spi)->name;
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = ad7298_channels;
>         indio_dev->num_channels = ARRAY_SIZE(ad7298_channels);
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 6286e230f55b..66c55ae67791 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -300,7 +300,6 @@ static int ad7476_probe(struct spi_device *spi)
>
>         st->spi = spi;
>
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = st->chip_info->channel;
> diff --git a/drivers/iio/adc/ad7791.c b/drivers/iio/adc/ad7791.c
> index b636cf0a8f19..d57ad966e17c 100644
> --- a/drivers/iio/adc/ad7791.c
> +++ b/drivers/iio/adc/ad7791.c
> @@ -425,7 +425,6 @@ static int ad7791_probe(struct spi_device *spi)
>
>         spi_set_drvdata(spi, indio_dev);
>
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = st->info->channels;
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index b858723c144b..5e980a06258e 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -818,7 +818,6 @@ static int ad7793_probe(struct spi_device *spi)
>
>         spi_set_drvdata(spi, indio_dev);
>
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = st->chip_info->channels;
> diff --git a/drivers/iio/adc/ad7887.c b/drivers/iio/adc/ad7887.c
> index 0f93f5c8965d..d1d43fb700ba 100644
> --- a/drivers/iio/adc/ad7887.c
> +++ b/drivers/iio/adc/ad7887.c
> @@ -264,7 +264,6 @@ static int ad7887_probe(struct spi_device *spi)
>         spi_set_drvdata(spi, indio_dev);
>         st->spi = spi;
>
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->info = &ad7887_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
> index 6f1996cfd1e5..bd3ce6b16a38 100644
> --- a/drivers/iio/adc/ad7923.c
> +++ b/drivers/iio/adc/ad7923.c
> @@ -315,7 +315,6 @@ static int ad7923_probe(struct spi_device *spi)
>         info = &ad7923_chip_info[spi_get_device_id(spi)->driver_data];
>
>         indio_dev->name = spi_get_device_id(spi)->name;
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = info->channels;
>         indio_dev->num_channels = info->num_channels;
> diff --git a/drivers/iio/adc/ad7949.c b/drivers/iio/adc/ad7949.c
> index c6676d317356..c6754ab54afa 100644
> --- a/drivers/iio/adc/ad7949.c
> +++ b/drivers/iio/adc/ad7949.c
> @@ -243,7 +243,6 @@ static int ad7949_spi_probe(struct spi_device *spi)
>                 return -ENOMEM;
>         }
>
> -       indio_dev->dev.of_node = dev->of_node;
>         indio_dev->info = &ad7949_spi_info;
>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 6a389bbbffaa..cfd814fca5bb 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -814,7 +814,6 @@ static int ad799x_probe(struct i2c_client *client,
>
>         st->client = client;
>
> -       indio_dev->dev.of_node = client->dev.of_node;
>         indio_dev->name = id->name;
>         indio_dev->info = st->chip_config->info;
>
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index b138f1a1fb51..798ff2d89691 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -668,7 +668,6 @@ static int axp20x_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, indio_dev);
>
>         info->regmap = axp20x_dev->regmap;
> -       indio_dev->dev.of_node = pdev->dev.of_node;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
>         if (!pdev->dev.of_node) {
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index 9bf29c2384a4..936da32faa9d 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -573,7 +573,6 @@ static int iproc_adc_probe(struct platform_device *pdev)
>         }
>
>         indio_dev->name = "iproc-static-adc";
> -       indio_dev->dev.of_node = pdev->dev.of_node;
>         indio_dev->info = &iproc_adc_iio_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = iproc_adc_iio_channels;
> diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
> index 9b0d6d7c90e9..004e7fee1fb2 100644
> --- a/drivers/iio/adc/cpcap-adc.c
> +++ b/drivers/iio/adc/cpcap-adc.c
> @@ -985,7 +985,6 @@ static int cpcap_adc_probe(struct platform_device *pdev)
>         init_waitqueue_head(&ddata->wq_data_avail);
>
>         indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> -       indio_dev->dev.of_node = pdev->dev.of_node;
>         indio_dev->channels = cpcap_adc_channels;
>         indio_dev->num_channels = ARRAY_SIZE(cpcap_adc_channels);
>         indio_dev->name = dev_name(&pdev->dev);
> diff --git a/drivers/iio/adc/da9150-gpadc.c b/drivers/iio/adc/da9150-gpadc.c
> index 3461e26a89bd..7a7a54a7ed76 100644
> --- a/drivers/iio/adc/da9150-gpadc.c
> +++ b/drivers/iio/adc/da9150-gpadc.c
> @@ -354,7 +354,6 @@ static int da9150_gpadc_probe(struct platform_device *pdev)
>         }
>
>         indio_dev->name = dev_name(dev);
> -       indio_dev->dev.of_node = pdev->dev.of_node;
>         indio_dev->info = &da9150_gpadc_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = da9150_gpadc_channels;
> diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
> index 77e60d160d02..2a4fd3bb64cf 100644
> --- a/drivers/iio/adc/envelope-detector.c
> +++ b/drivers/iio/adc/envelope-detector.c
> @@ -343,7 +343,6 @@ static int envelope_detector_probe(struct platform_device *pdev)
>         INIT_DELAYED_WORK(&env->comp_timeout, envelope_detector_timeout);
>
>         indio_dev->name = dev_name(dev);
> -       indio_dev->dev.of_node = dev->of_node;
>         indio_dev->info = &envelope_detector_info;
>         indio_dev->channels = &envelope_detector_iio_channel;
>         indio_dev->num_channels = 1;
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 27606fa7c7bb..7d23b6c33284 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -867,7 +867,6 @@ static int exynos_adc_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, indio_dev);
>
>         indio_dev->name = dev_name(&pdev->dev);
> -       indio_dev->dev.of_node = pdev->dev.of_node;
>         indio_dev->info = &exynos_adc_iio_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = exynos_adc_iio_channels;
> diff --git a/drivers/iio/adc/hi8435.c b/drivers/iio/adc/hi8435.c
> index dd23b8593b7b..127e78243233 100644
> --- a/drivers/iio/adc/hi8435.c
> +++ b/drivers/iio/adc/hi8435.c
> @@ -488,7 +488,6 @@ static int hi8435_probe(struct spi_device *spi)
>         spi_set_drvdata(spi, idev);
>         mutex_init(&priv->lock);
>
> -       idev->dev.of_node       = spi->dev.of_node;
>         idev->name              = spi_get_device_id(spi)->name;
>         idev->modes             = INDIO_DIRECT_MODE;
>         idev->info              = &hi8435_info;
> diff --git a/drivers/iio/adc/ina2xx-adc.c b/drivers/iio/adc/ina2xx-adc.c
> index 467f48b6f451..6ba94a410040 100644
> --- a/drivers/iio/adc/ina2xx-adc.c
> +++ b/drivers/iio/adc/ina2xx-adc.c
> @@ -1015,7 +1015,6 @@ static int ina2xx_probe(struct i2c_client *client,
>         }
>
>         indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> -       indio_dev->dev.of_node = client->dev.of_node;
>         if (id->driver_data == ina226) {
>                 indio_dev->channels = ina226_channels;
>                 indio_dev->num_channels = ARRAY_SIZE(ina226_channels);
> diff --git a/drivers/iio/adc/lp8788_adc.c b/drivers/iio/adc/lp8788_adc.c
> index 6e32d2ac1ace..8fb57e375529 100644
> --- a/drivers/iio/adc/lp8788_adc.c
> +++ b/drivers/iio/adc/lp8788_adc.c
> @@ -198,7 +198,6 @@ static int lp8788_adc_probe(struct platform_device *pdev)
>         adc->lp = lp;
>         platform_set_drvdata(pdev, indio_dev);
>
> -       indio_dev->dev.of_node = pdev->dev.of_node;
>         ret = lp8788_iio_map_register(indio_dev, lp->pdata, adc);
>         if (ret)
>                 return ret;
> diff --git a/drivers/iio/adc/max1027.c b/drivers/iio/adc/max1027.c
> index b489cb14ea0d..9e993ccd14de 100644
> --- a/drivers/iio/adc/max1027.c
> +++ b/drivers/iio/adc/max1027.c
> @@ -440,7 +440,6 @@ static int max1027_probe(struct spi_device *spi)
>         mutex_init(&st->lock);
>
>         indio_dev->name = spi_get_device_id(spi)->name;
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->info = &max1027_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = st->info->channels;
> diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
> index a5a4e82b8bd2..57734f9742f6 100644
> --- a/drivers/iio/adc/max11100.c
> +++ b/drivers/iio/adc/max11100.c
> @@ -115,7 +115,6 @@ static int max11100_probe(struct spi_device *spi)
>         state = iio_priv(indio_dev);
>         state->spi = spi;
>
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->name = "max11100";
>         indio_dev->info = &max11100_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index cc1ba7bfc8e6..d8da5da74b77 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1593,7 +1593,6 @@ static int max1363_probe(struct i2c_client *client,
>         if (!indio_dev)
>                 return -ENOMEM;
>
> -       indio_dev->dev.of_node = client->dev.of_node;
>         ret = iio_map_array_register(indio_dev, client->dev.platform_data);
>         if (ret < 0)
>                 return ret;
> @@ -1652,7 +1651,6 @@ static int max1363_probe(struct i2c_client *client,
>         if (ret)
>                 goto error_disable_reg;
>
> -       indio_dev->dev.of_node = client->dev.of_node;
>         indio_dev->name = id->name;
>         indio_dev->channels = st->chip_info->channels;
>         indio_dev->num_channels = st->chip_info->num_channels;
> diff --git a/drivers/iio/adc/max9611.c b/drivers/iio/adc/max9611.c
> index f0fdd08cea91..d7f150abbaac 100644
> --- a/drivers/iio/adc/max9611.c
> +++ b/drivers/iio/adc/max9611.c
> @@ -545,7 +545,6 @@ static int max9611_probe(struct i2c_client *client,
>         if (ret)
>                 return ret;
>
> -       indio_dev->dev.of_node  = client->dev.of_node;
>         indio_dev->name         = of_id->data;
>         indio_dev->modes        = INDIO_DIRECT_MODE;
>         indio_dev->info         = &indio_info;
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index ee1f65f011a3..e533f1064cf8 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -384,7 +384,6 @@ static int mcp320x_probe(struct spi_device *spi)
>         adc = iio_priv(indio_dev);
>         adc->spi = spi;
>
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &mcp320x_info;
> diff --git a/drivers/iio/adc/mcp3422.c b/drivers/iio/adc/mcp3422.c
> index 56a4768185ea..40e0d3ed05a5 100644
> --- a/drivers/iio/adc/mcp3422.c
> +++ b/drivers/iio/adc/mcp3422.c
> @@ -347,7 +347,6 @@ static int mcp3422_probe(struct i2c_client *client,
>
>         mutex_init(&adc->lock);
>
> -       indio_dev->dev.of_node = client->dev.of_node;
>         indio_dev->name = dev_name(&client->dev);
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &mcp3422_info;
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 818b92518c66..e573da5397bb 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -293,7 +293,6 @@ static int mcp3911_probe(struct spi_device *spi)
>         if (ret)
>                 goto clk_disable;
>
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &mcp3911_info;
> diff --git a/drivers/iio/adc/meson_saradc.c b/drivers/iio/adc/meson_saradc.c
> index 1026cb199aa3..93c2252c0b89 100644
> --- a/drivers/iio/adc/meson_saradc.c
> +++ b/drivers/iio/adc/meson_saradc.c
> @@ -1208,7 +1208,6 @@ static int meson_sar_adc_probe(struct platform_device *pdev)
>         priv->param = match_data->param;
>
>         indio_dev->name = match_data->name;
> -       indio_dev->dev.of_node = pdev->dev.of_node;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &meson_sar_adc_iio_info;
>
> diff --git a/drivers/iio/adc/nau7802.c b/drivers/iio/adc/nau7802.c
> index e2ed9f575a46..07c85434b568 100644
> --- a/drivers/iio/adc/nau7802.c
> +++ b/drivers/iio/adc/nau7802.c
> @@ -430,7 +430,6 @@ static int nau7802_probe(struct i2c_client *client,
>
>         i2c_set_clientdata(client, indio_dev);
>
> -       indio_dev->dev.of_node = client->dev.of_node;
>         indio_dev->name = dev_name(&client->dev);
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &nau7802_info;
> diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> index d3225965a1af..368ee4ef71a4 100644
> --- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> +++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
> @@ -933,7 +933,6 @@ static int pm8xxx_xoadc_probe(struct platform_device *pdev)
>                 goto out_disable_vref;
>         }
>
> -       indio_dev->dev.of_node = np;
>         indio_dev->name = variant->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &pm8xxx_xoadc_info;
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 2f8379a98ae5..faecae8b1728 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -982,7 +982,6 @@ static int adc5_probe(struct platform_device *pdev)
>                         return ret;
>         }
>
> -       indio_dev->dev.of_node = node;
>         indio_dev->name = pdev->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = adc->data->info;
> diff --git a/drivers/iio/adc/qcom-spmi-iadc.c b/drivers/iio/adc/qcom-spmi-iadc.c
> index 1c90ad33a881..acbda6636dc5 100644
> --- a/drivers/iio/adc/qcom-spmi-iadc.c
> +++ b/drivers/iio/adc/qcom-spmi-iadc.c
> @@ -553,7 +553,6 @@ static int iadc_probe(struct platform_device *pdev)
>                 return ret;
>         }
>
> -       indio_dev->dev.of_node = node;
>         indio_dev->name = pdev->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &iadc_info;
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index 1f1bb747c8e1..b0388f8a69f4 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -907,7 +907,6 @@ static int vadc_probe(struct platform_device *pdev)
>         if (ret)
>                 return ret;
>
> -       indio_dev->dev.of_node = node;
>         indio_dev->name = pdev->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &vadc_info;
> diff --git a/drivers/iio/adc/rcar-gyroadc.c b/drivers/iio/adc/rcar-gyroadc.c
> index 8591d3871791..d2c1419e72a0 100644
> --- a/drivers/iio/adc/rcar-gyroadc.c
> +++ b/drivers/iio/adc/rcar-gyroadc.c
> @@ -516,7 +516,6 @@ static int rcar_gyroadc_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, indio_dev);
>
>         indio_dev->name = DRIVER_NAME;
> -       indio_dev->dev.of_node = pdev->dev.of_node;
>         indio_dev->info = &rcar_gyroadc_iio_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index dabcd3e1365f..d32ec8dfedf5 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -307,7 +307,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, indio_dev);
>
>         indio_dev->name = dev_name(&pdev->dev);
> -       indio_dev->dev.of_node = pdev->dev.of_node;
>         indio_dev->info = &rockchip_saradc_iio_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
> diff --git a/drivers/iio/adc/sd_adc_modulator.c b/drivers/iio/adc/sd_adc_modulator.c
> index c32bb7bb5a96..1d6c246609c8 100644
> --- a/drivers/iio/adc/sd_adc_modulator.c
> +++ b/drivers/iio/adc/sd_adc_modulator.c
> @@ -32,7 +32,6 @@ static int iio_sd_mod_probe(struct platform_device *pdev)
>         if (!iio)
>                 return -ENOMEM;
>
> -       iio->dev.of_node = dev->of_node;
>         iio->name = dev_name(dev);
>         iio->info = &iio_sd_mod_iio_info;
>         iio->modes = INDIO_BUFFER_HARDWARE;
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index 06b02f5b1721..99b43f28e879 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -619,7 +619,6 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
>         info->indio_dev = indio_dev;
>         init_completion(&info->completion);
>         indio_dev->name = dev_name(&pdev->dev);
> -       indio_dev->dev.of_node = pdev->dev.of_node;
>         indio_dev->info = &sun4i_gpadc_iio_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
> diff --git a/drivers/iio/adc/ti-adc081c.c b/drivers/iio/adc/ti-adc081c.c
> index e44e7a40a36b..82e524b3db88 100644
> --- a/drivers/iio/adc/ti-adc081c.c
> +++ b/drivers/iio/adc/ti-adc081c.c
> @@ -181,7 +181,6 @@ static int adc081c_probe(struct i2c_client *client,
>         if (err < 0)
>                 return err;
>
> -       iio->dev.of_node = client->dev.of_node;
>         iio->name = dev_name(&client->dev);
>         iio->modes = INDIO_DIRECT_MODE;
>         iio->info = &adc081c_info;
> diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
> index 054db3425afa..3eb3ba5fb610 100644
> --- a/drivers/iio/adc/ti-adc0832.c
> +++ b/drivers/iio/adc/ti-adc0832.c
> @@ -245,7 +245,6 @@ static int adc0832_probe(struct spi_device *spi)
>         mutex_init(&adc->lock);
>
>         indio_dev->name = spi_get_device_id(spi)->name;
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->info = &adc0832_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
> diff --git a/drivers/iio/adc/ti-adc084s021.c b/drivers/iio/adc/ti-adc084s021.c
> index 376a0cf1f4ff..f22f004c1eb6 100644
> --- a/drivers/iio/adc/ti-adc084s021.c
> +++ b/drivers/iio/adc/ti-adc084s021.c
> @@ -211,7 +211,6 @@ static int adc084s021_probe(struct spi_device *spi)
>         spi_set_drvdata(spi, indio_dev);
>
>         /* Initiate the Industrial I/O device */
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &adc084s021_info;
> diff --git a/drivers/iio/adc/ti-adc128s052.c b/drivers/iio/adc/ti-adc128s052.c
> index 4eca6404661c..c1552b0fee04 100644
> --- a/drivers/iio/adc/ti-adc128s052.c
> +++ b/drivers/iio/adc/ti-adc128s052.c
> @@ -152,7 +152,6 @@ static int adc128_probe(struct spi_device *spi)
>
>         spi_set_drvdata(spi, indio_dev);
>
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &adc128_info;
> diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
> index d6f28d478a73..f27ca3161530 100644
> --- a/drivers/iio/adc/ti-adc161s626.c
> +++ b/drivers/iio/adc/ti-adc161s626.c
> @@ -179,7 +179,6 @@ static int ti_adc_probe(struct spi_device *spi)
>                 return -ENOMEM;
>
>         indio_dev->info = &ti_adc_info;
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->name = TI_ADC_DRV_NAME;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         spi_set_drvdata(spi, indio_dev);
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 629c631e8f5c..1a5f520080d2 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -939,7 +939,6 @@ static int ads1015_probe(struct i2c_client *client,
>
>         mutex_init(&data->lock);
>
> -       indio_dev->dev.of_node = client->dev.of_node;
>         indio_dev->name = ADS1015_DRV_NAME;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>
> diff --git a/drivers/iio/adc/ti-ads124s08.c b/drivers/iio/adc/ti-ads124s08.c
> index dacaa7255a3b..2844fe5714b9 100644
> --- a/drivers/iio/adc/ti-ads124s08.c
> +++ b/drivers/iio/adc/ti-ads124s08.c
> @@ -325,7 +325,6 @@ static int ads124s_probe(struct spi_device *spi)
>         ads124s_priv->spi = spi;
>
>         indio_dev->name = spi_id->name;
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = ads124s_priv->chip_info->channels;
>         indio_dev->num_channels = ads124s_priv->chip_info->num_channels;
> diff --git a/drivers/iio/adc/ti-ads8344.c b/drivers/iio/adc/ti-ads8344.c
> index 7d99a67082a4..565b00d6ae1b 100644
> --- a/drivers/iio/adc/ti-ads8344.c
> +++ b/drivers/iio/adc/ti-ads8344.c
> @@ -146,7 +146,6 @@ static int ads8344_probe(struct spi_device *spi)
>         mutex_init(&adc->lock);
>
>         indio_dev->name = dev_name(&spi->dev);
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->info = &ads8344_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = ads8344_channels;
> diff --git a/drivers/iio/adc/ti-ads8688.c b/drivers/iio/adc/ti-ads8688.c
> index 011e5c8b5afd..16bcb37eebb7 100644
> --- a/drivers/iio/adc/ti-ads8688.c
> +++ b/drivers/iio/adc/ti-ads8688.c
> @@ -449,7 +449,6 @@ static int ads8688_probe(struct spi_device *spi)
>         st->spi = spi;
>
>         indio_dev->name = spi_get_device_id(spi)->name;
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = st->chip_info->channels;
>         indio_dev->num_channels = st->chip_info->num_channels;
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> index e5602169e681..50fbe56ec571 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -772,7 +772,6 @@ static int twl4030_madc_probe(struct platform_device *pdev)
>         madc->dev = &pdev->dev;
>
>         iio_dev->name = dev_name(&pdev->dev);
> -       iio_dev->dev.of_node = pdev->dev.of_node;
>         iio_dev->info = &twl4030_madc_iio_info;
>         iio_dev->modes = INDIO_DIRECT_MODE;
>         iio_dev->channels = twl4030_madc_iio_channels;
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 1e3ef5dd0bc6..f5637bf38d37 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -860,7 +860,6 @@ static int vf610_adc_probe(struct platform_device *pdev)
>         init_completion(&info->completion);
>
>         indio_dev->name = dev_name(&pdev->dev);
> -       indio_dev->dev.of_node = pdev->dev.of_node;
>         indio_dev->info = &vf610_adc_iio_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = vf610_adc_iio_channels;
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index aeefd9768203..69be9e82fe3e 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -1221,7 +1221,6 @@ static int xadc_probe(struct platform_device *pdev)
>         if (IS_ERR(xadc->base))
>                 return PTR_ERR(xadc->base);
>
> -       indio_dev->dev.of_node = pdev->dev.of_node;
>         indio_dev->name = "xadc";
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &xadc_info;
> diff --git a/drivers/iio/dac/ds4424.c b/drivers/iio/dac/ds4424.c
> index 86eec0df1174..79527fbc250a 100644
> --- a/drivers/iio/dac/ds4424.c
> +++ b/drivers/iio/dac/ds4424.c
> @@ -230,7 +230,6 @@ static int ds4424_probe(struct i2c_client *client,
>         i2c_set_clientdata(client, indio_dev);
>         data->client = client;
>         indio_dev->name = id->name;
> -       indio_dev->dev.of_node = client->dev.of_node;
>
>         data->vcc_reg = devm_regulator_get(&client->dev, "vcc");
>         if (IS_ERR(data->vcc_reg)) {
> diff --git a/drivers/iio/dac/ti-dac5571.c b/drivers/iio/dac/ti-dac5571.c
> index 502552716e1e..f08c0a859ad4 100644
> --- a/drivers/iio/dac/ti-dac5571.c
> +++ b/drivers/iio/dac/ti-dac5571.c
> @@ -321,7 +321,6 @@ static int dac5571_probe(struct i2c_client *client,
>         i2c_set_clientdata(client, indio_dev);
>         data->client = client;
>
> -       indio_dev->dev.of_node = client->dev.of_node;
>         indio_dev->info = &dac5571_info;
>         indio_dev->name = id->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/iio/dac/ti-dac7311.c b/drivers/iio/dac/ti-dac7311.c
> index d20cee33daba..a5ff6131009b 100644
> --- a/drivers/iio/dac/ti-dac7311.c
> +++ b/drivers/iio/dac/ti-dac7311.c
> @@ -251,7 +251,6 @@ static int ti_dac_probe(struct spi_device *spi)
>         spi->bits_per_word = 16;
>         spi_setup(spi);
>
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->info = &ti_dac_info;
>         indio_dev->name = spi_get_device_id(spi)->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/iio/dac/vf610_dac.c b/drivers/iio/dac/vf610_dac.c
> index 344b55307c60..b70c6ef8d4db 100644
> --- a/drivers/iio/dac/vf610_dac.c
> +++ b/drivers/iio/dac/vf610_dac.c
> @@ -199,7 +199,6 @@ static int vf610_dac_probe(struct platform_device *pdev)
>         platform_set_drvdata(pdev, indio_dev);
>
>         indio_dev->name = dev_name(&pdev->dev);
> -       indio_dev->dev.of_node = pdev->dev.of_node;
>         indio_dev->info = &vf610_dac_iio_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = vf610_dac_iio_channels;
> diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
> index 7afe37c97575..ab779a3be015 100644
> --- a/drivers/iio/pressure/dlhl60d.c
> +++ b/drivers/iio/pressure/dlhl60d.c
> @@ -311,7 +311,6 @@ static int dlh_probe(struct i2c_client *client,
>         st->use_interrupt = false;
>
>         indio_dev->name = id->name;
> -       indio_dev->dev.of_node = client->dev.of_node;
>         indio_dev->info = &dlh_info;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels =  dlh_channels;
> diff --git a/drivers/iio/temperature/max31856.c b/drivers/iio/temperature/max31856.c
> index ffc54289fca7..1954322e43be 100644
> --- a/drivers/iio/temperature/max31856.c
> +++ b/drivers/iio/temperature/max31856.c
> @@ -417,7 +417,6 @@ static int max31856_probe(struct spi_device *spi)
>         spi_set_drvdata(spi, indio_dev);
>
>         indio_dev->info = &max31856_info;
> -       indio_dev->dev.of_node = spi->dev.of_node;
>         indio_dev->name = id->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->channels = max31856_channels;
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index e7459ad3d6cd..3aa9e8bba005 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -727,7 +727,6 @@ static struct stm32_timer_trigger *stm32_setup_counter_device(struct device *dev
>         indio_dev->modes = INDIO_HARDWARE_TRIGGERED;
>         indio_dev->num_channels = 1;
>         indio_dev->channels = &stm32_trigger_channel;
> -       indio_dev->dev.of_node = dev->of_node;
>
>         ret = devm_iio_device_register(dev, indio_dev);
>         if (ret)
> --
> 2.20.1
>


-- 
With Best Regards,
Andy Shevchenko
