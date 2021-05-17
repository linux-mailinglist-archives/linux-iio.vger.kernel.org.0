Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6902382534
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 09:19:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbhEQHUW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 03:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbhEQHUW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 03:20:22 -0400
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A58DC061573
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:19:06 -0700 (PDT)
Received: by mail-vs1-xe2c.google.com with SMTP id x13so2627271vsh.1
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UArU4tk/oUoSh0u4Kxn71FZP6xAlH+wDL2JVijTYhuY=;
        b=aCJVvYRPKeJHFcHABvjAvxtVLLQKzV2IiAvAEuLefLS2usMZnzpAzfJFpAzJ6IS58+
         qaan3K/4ZMXCwX/LvLUAZDx3tozRYL5dvBsl5Q02dBpM3jQYBIgXvu00iRHPgr+cVFxI
         ELXPWtnOIXH8ALUw7YbgmDhXsWqXKeThaTgyz0Q8XlQaRtmWoFI6qXRQ5hZ64VmLJi61
         +M4sJNqTPPYob8GXgW/M6q6JzyeGSs1ZZk0DJqE934mw1j7dzvfYh9Yo6cEoMZ1v9x1x
         nAxg9QaNQajfgbsBuddfPFGWZTqT0mn+x0wEpPEG0VHBVi1DDlzGngWeFe+BhHFGscrZ
         1A7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UArU4tk/oUoSh0u4Kxn71FZP6xAlH+wDL2JVijTYhuY=;
        b=W9pnLAODBlijloWlBkvL4leEs/zvmlN67BKcW0S1ZgPSCfe39cGsB4rtiyOgOZ6yEq
         aTF6PnhiytRMuVcyRCiEypJQ7hzmrkd3VNQ/B8w9ZmBy6w09zveka4Aj0yB2+2/gDZHM
         OVEbdz+0FwKEzZDhVHysXMf6vn5TdnXMzV3t3M25ckmgQA6oVAj+pudlsuJTzsd0HPqI
         81FSI8GbpTloyTS8obIuAdZXW/txpfv9Rxc6/lL6PrxzLwOcprm7h9Seq9TsmxJrfuWp
         wGvIbrSW/dXdbsUiMp8DXcJEUgCX1KlFxIuVCIOQO1JzsjEJ4QzC2nIxoLYmiTjstNGT
         0pzA==
X-Gm-Message-State: AOAM5317BKzCfzLx+fcd5U+e4BK65y8Km0GUH7CS+w6r1dqZluVU6vXQ
        oqfBF6UESTT9LAR9UwbeMkOpv3eGLQAkvnfeauww1A==
X-Google-Smtp-Source: ABdhPJzdkRRJc/jjtGyk9NsfNTJ0vfnbEOxPYBDf7JKYZipW2HoafWVq57JS7dP1IKGS0J56NZvcRyi5fDoaQORrRGg=
X-Received: by 2002:a67:fb52:: with SMTP id e18mr9452014vsr.18.1621235945450;
 Mon, 17 May 2021 00:19:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210516172520.1398835-1-jic23@kernel.org> <20210516172520.1398835-4-jic23@kernel.org>
In-Reply-To: <20210516172520.1398835-4-jic23@kernel.org>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 17 May 2021 10:18:54 +0300
Message-ID: <CAASAkoaHtG4K38CJ=ZWRLYL-w=MeYq_jHBjsotjZhnPcZDJv4A@mail.gmail.com>
Subject: Re: [PATCH 3/8] iio: adc: max1118: Use devm_ managed functions for
 all of probe
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 May 2021 at 20:26, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This simplifies error handling and allows us to drop the remove
> function entirely.
>

Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  drivers/iio/adc/max1118.c | 46 +++++++++++++--------------------------
>  1 file changed, 15 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/iio/adc/max1118.c b/drivers/iio/adc/max1118.c
> index 6efb0b43d938..4dfbed63ad7f 100644
> --- a/drivers/iio/adc/max1118.c
> +++ b/drivers/iio/adc/max1118.c
> @@ -201,6 +201,11 @@ static irqreturn_t max1118_trigger_handler(int irq, void *p)
>         return IRQ_HANDLED;
>  }
>
> +static void max1118_reg_disable(void *reg)
> +{
> +       regulator_disable(reg);
> +}
> +
>  static int max1118_probe(struct spi_device *spi)
>  {
>         struct iio_dev *indio_dev;
> @@ -225,6 +230,12 @@ static int max1118_probe(struct spi_device *spi)
>                 ret = regulator_enable(adc->reg);
>                 if (ret)
>                         return ret;
> +
> +               ret = devm_add_action_or_reset(&spi->dev, max1118_reg_disable,
> +                                              adc->reg);
> +               if (ret)
> +                       return ret;
> +
>         }
>
>         spi_set_drvdata(spi, indio_dev);
> @@ -243,38 +254,12 @@ static int max1118_probe(struct spi_device *spi)
>          */
>         max1118_read(spi, 0);
>
> -       ret = iio_triggered_buffer_setup(indio_dev, NULL,
> -                                       max1118_trigger_handler, NULL);
> +       ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
> +                                             max1118_trigger_handler, NULL);
>         if (ret)
> -               goto err_reg_disable;
> -
> -       ret = iio_device_register(indio_dev);
> -       if (ret)
> -               goto err_buffer_cleanup;
> -
> -       return 0;
> -
> -err_buffer_cleanup:
> -       iio_triggered_buffer_cleanup(indio_dev);
> -err_reg_disable:
> -       if (id->driver_data == max1118)
> -               regulator_disable(adc->reg);
> -
> -       return ret;
> -}
> -
> -static int max1118_remove(struct spi_device *spi)
> -{
> -       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -       struct max1118 *adc = iio_priv(indio_dev);
> -       const struct spi_device_id *id = spi_get_device_id(spi);
> -
> -       iio_device_unregister(indio_dev);
> -       iio_triggered_buffer_cleanup(indio_dev);
> -       if (id->driver_data == max1118)
> -               return regulator_disable(adc->reg);
> +               return ret;
>
> -       return 0;
> +       return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>
>  static const struct spi_device_id max1118_id[] = {
> @@ -299,7 +284,6 @@ static struct spi_driver max1118_spi_driver = {
>                 .of_match_table = max1118_dt_ids,
>         },
>         .probe = max1118_probe,
> -       .remove = max1118_remove,
>         .id_table = max1118_id,
>  };
>  module_spi_driver(max1118_spi_driver);
> --
> 2.31.1
>
