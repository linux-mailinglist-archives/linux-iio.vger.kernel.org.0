Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9910448987F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jan 2022 13:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245434AbiAJMVV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jan 2022 07:21:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245437AbiAJMU3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jan 2022 07:20:29 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44319C061759
        for <linux-iio@vger.kernel.org>; Mon, 10 Jan 2022 04:20:28 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id d3so17283471lfv.13
        for <linux-iio@vger.kernel.org>; Mon, 10 Jan 2022 04:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e+gczxkrQRD/dQ/jBxW7gRFcfdkPGHbr2WDGhZJZLJk=;
        b=DQ6s1LJZPoFp6X8JefkipbzDh1yGPvq/kl1jdeBlsANQVeciRIMsENC9zSQpWhq78S
         DkLgBNC+TfpIiuLamGmaYI/Vw+fFUzv/+tb+8WxqADvgFfapxzYO4Y8o9htnFCBX5XVo
         OkoRHRNuvnooWK+eUM4gZoQbnEN8JAsKaL10RXyO2vt8XnLdQYPDpo7tZCO6GM3DYVOm
         tjfM6SUY+MOaFz4ShgbZ/qWOxrpITTHFtNmjLiv35EOj/NFFeExH71NRmpgJ5F8Tu46A
         vdgmSyZmLYeu7KK0Gm99B96rrE4Ktc0hKeRwx7PDGEbuDL1cXCMk8lJnFm6c9CCgcdez
         CFJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e+gczxkrQRD/dQ/jBxW7gRFcfdkPGHbr2WDGhZJZLJk=;
        b=dYUfetoDY0/Mhi+rx/8YfKiON+VHagaZanSm9LbUmmhFQaUywl2oAM+0+UMAhz54km
         1qEVhJNHXcNpycUh6K6GJFgQBE0lOkTqMoTl+320wSRi9+4HHMsOZ4IHZjmyGQXd5/mA
         ES05g8+TiACnb3fbD9Mfwh4RUVroRDRvC5UxLJ23tTVD1EFD2rBpprILNlFCUvrZAltL
         J8x9EEsoa7LS+PZ2zKQPPRSgJLn12ZIgzgWMbp+LqXGHxGn5gxs0DuGVdQRBh2BCXo5P
         ghYdRXWtC7No3u1xQ2pozGwulOHt76aUaB2/RCm21XgT+mTLdOD07aq3bZ1uDeNQ1gOI
         i+Zw==
X-Gm-Message-State: AOAM533GA3mbCXnrCQIKYi3S4SWmWXtgCvsuxKCH+KeJPMAok42VXqBL
        42/Bb/waNr8APjn5IXkL+9KDq0OH7JCOEjocTrUasA==
X-Google-Smtp-Source: ABdhPJwHuXQxrdr9hK3bUVDPLAm90cjss/wNF/ISoPLrywRMtIzRfPeLJ7C3G8WRGhNdQHZCB3M+ZVJPLMsNh8wGOzg=
X-Received: by 2002:a2e:9659:: with SMTP id z25mr59418630ljh.16.1641817226570;
 Mon, 10 Jan 2022 04:20:26 -0800 (PST)
MIME-Version: 1.0
References: <20220107181723.54392-1-paul@crapouillou.net> <20220107181723.54392-7-paul@crapouillou.net>
In-Reply-To: <20220107181723.54392-7-paul@crapouillou.net>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 10 Jan 2022 13:19:50 +0100
Message-ID: <CAPDyKFoA6Jj_xdRtvgahue7cSWrW1HOX=1=-9COwiZqRrRd7bw@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] iio: pressure: bmp280: Use new PM macros
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Len Brown <len.brown@intel.com>,
        Pavel Machek <pavel@ucw.cz>, list@opendingux.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 7 Jan 2022 at 19:18, Paul Cercueil <paul@crapouillou.net> wrote:
>
> Use the new EXPORT_RUNTIME_DEV_PM_OPS() macro. It allows the underlying
> dev_pm_ops struct as well as the suspend/resume callbacks to be detected
> as dead code in the case where CONFIG_PM is disabled, without having to
> wrap everything inside #ifdef CONFIG_PM guards.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>
> Notes:
>     v2: New patch
>     v3: No change
>
>  drivers/iio/pressure/bmp280-core.c | 11 ++---------
>  drivers/iio/pressure/bmp280-i2c.c  |  2 +-
>  drivers/iio/pressure/bmp280-spi.c  |  2 +-
>  3 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index 6b7da40f99c8..bf8167f43c56 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1138,7 +1138,6 @@ int bmp280_common_probe(struct device *dev,
>  }
>  EXPORT_SYMBOL(bmp280_common_probe);
>
> -#ifdef CONFIG_PM
>  static int bmp280_runtime_suspend(struct device *dev)
>  {
>         struct iio_dev *indio_dev = dev_get_drvdata(dev);
> @@ -1159,15 +1158,9 @@ static int bmp280_runtime_resume(struct device *dev)
>         usleep_range(data->start_up_time, data->start_up_time + 100);
>         return data->chip_info->chip_config(data);
>  }
> -#endif /* CONFIG_PM */
>
> -const struct dev_pm_ops bmp280_dev_pm_ops = {
> -       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> -                               pm_runtime_force_resume)
> -       SET_RUNTIME_PM_OPS(bmp280_runtime_suspend,
> -                          bmp280_runtime_resume, NULL)
> -};
> -EXPORT_SYMBOL(bmp280_dev_pm_ops);
> +EXPORT_RUNTIME_DEV_PM_OPS(bmp280_dev_pm_ops, bmp280_runtime_suspend,
> +                         bmp280_runtime_resume, NULL);
>
>  MODULE_AUTHOR("Vlad Dogaru <vlad.dogaru@intel.com>");
>  MODULE_DESCRIPTION("Driver for Bosch Sensortec BMP180/BMP280 pressure and temperature sensor");
> diff --git a/drivers/iio/pressure/bmp280-i2c.c b/drivers/iio/pressure/bmp280-i2c.c
> index 8b03ea15c0d0..35045bd92846 100644
> --- a/drivers/iio/pressure/bmp280-i2c.c
> +++ b/drivers/iio/pressure/bmp280-i2c.c
> @@ -58,7 +58,7 @@ static struct i2c_driver bmp280_i2c_driver = {
>         .driver = {
>                 .name   = "bmp280",
>                 .of_match_table = bmp280_of_i2c_match,
> -               .pm = &bmp280_dev_pm_ops,
> +               .pm = pm_ptr(&bmp280_dev_pm_ops),
>         },
>         .probe          = bmp280_i2c_probe,
>         .id_table       = bmp280_i2c_id,
> diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> index 625b86878ad8..41f6cc56d229 100644
> --- a/drivers/iio/pressure/bmp280-spi.c
> +++ b/drivers/iio/pressure/bmp280-spi.c
> @@ -109,7 +109,7 @@ static struct spi_driver bmp280_spi_driver = {
>         .driver = {
>                 .name = "bmp280",
>                 .of_match_table = bmp280_of_spi_match,
> -               .pm = &bmp280_dev_pm_ops,
> +               .pm = pm_ptr(&bmp280_dev_pm_ops),
>         },
>         .id_table = bmp280_spi_id,
>         .probe = bmp280_spi_probe,
> --
> 2.34.1
>
