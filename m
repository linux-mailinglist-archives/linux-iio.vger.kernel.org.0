Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C684382560
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 09:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhEQHdK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 03:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbhEQHdJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 03:33:09 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBCAC061573
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:31:53 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id a12so1803186uak.6
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RBo5/QfxGz5kTMKWhnRVGkkuo+TN+/uAjc6LxUWKZxA=;
        b=d4IPe0hQcv/8teXHxaABjm7aPkXcITHSatPvxezv2M85xuaXLxTZ0dpcyiGhbnnKDj
         9LjsKCXYWzhrPuV+ZJGWN6JA8hu0UFXD2DWbmYcOpGWUChqX5HuTw5vFivK5EaxalBfW
         EJ35MNyiYIb8ItIW2gghaBZAf4iD6DBGbKP1uHK1UgFiMLA/A16N1lvH8CyrAMPgXwMk
         9LwdqaZMcZwMqlGYIbHn6yoXTFukfuebQUwA5mghOtoi9zW0ODbgotGPSFHH6KBqjcn1
         /3giHNw33FsdqXPAC2qDmtrP4Z7TkC/8ATmrDocBZtQinBtwnsATDauIJmZFMj4zKvV+
         6UJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RBo5/QfxGz5kTMKWhnRVGkkuo+TN+/uAjc6LxUWKZxA=;
        b=CuJK6/EULPZuyF9S0h9YuShWFvNmJIrHhwKX02lMiWFcdnON6Myuq4EPNDK94DAH/8
         96BWTkhvfXGay6Sla3/OXnFh2b3WoIa2kwtRho3v1jOLlp/pTQ4v79btFZ39hjGXgLzi
         a0QsfZrH+jqwwbC4CfTLGMg/78QwTW/xN309B1xD/TUaUkTwpwUXgKLUA5wHdXRnMPHZ
         Zp7cmiEl4K369clRelPTq3HfNNux+xZYIrSMKptC4jQkZNkFvFgoJ6FiKzBDaOthbUc/
         /tKpO3cLCotMeEXUffLtZ7l1XGnYepWwHTxse3k1XLijGj2cVuj9/vas1w2kkLWqo69L
         /LFg==
X-Gm-Message-State: AOAM533T0jhSRcqJhUtZDq/VRVNiPesFO5oA8uGoWJ6S5ntJAins2A9b
        7SkopZGlK58hjUndDMbmmZUeyPA8xxiQkCIuhOThTZlnf69m7wP3Nik=
X-Google-Smtp-Source: ABdhPJy+TeCfUFZ2RxLUGH9CMMyAx2aJQyksbJDx2roZ9+capJnuQjVXzyAqs2e8yYT/RczwuYmt5qqdbrBn4wwOsqI=
X-Received: by 2002:ab0:7250:: with SMTP id d16mr53153824uap.7.1621236713049;
 Mon, 17 May 2021 00:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210516172520.1398835-1-jic23@kernel.org> <20210516172520.1398835-8-jic23@kernel.org>
In-Reply-To: <20210516172520.1398835-8-jic23@kernel.org>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 17 May 2021 10:31:42 +0300
Message-ID: <CAASAkoYqGqwQcHZpSJHBZp+t_9bAZ04DSqAzM9=yHB4aaj_VWw@mail.gmail.com>
Subject: Re: [PATCH 7/8] iio: adc: ti-adc108s102: Use devm managed functions
 for all of probe()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bogdan Pricop <bogdan.pricop@emutex.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 May 2021 at 20:26, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Simplifies error handling and lets us drop remove() entirely.
>

Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>


> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Bogdan Pricop <bogdan.pricop@emutex.com>
> ---
>  drivers/iio/adc/ti-adc108s102.c | 45 +++++++++++----------------------
>  1 file changed, 15 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-adc108s102.c b/drivers/iio/adc/ti-adc108s102.c
> index 183b2245e89b..db902aef2abe 100644
> --- a/drivers/iio/adc/ti-adc108s102.c
> +++ b/drivers/iio/adc/ti-adc108s102.c
> @@ -215,6 +215,11 @@ static const struct iio_info adc108s102_info = {
>         .update_scan_mode       = &adc108s102_update_scan_mode,
>  };
>
> +static void adc108s102_reg_disable(void *reg)
> +{
> +       regulator_disable(reg);
> +}
> +
>  static int adc108s102_probe(struct spi_device *spi)
>  {
>         struct adc108s102_state *st;
> @@ -239,6 +244,10 @@ static int adc108s102_probe(struct spi_device *spi)
>                         dev_err(&spi->dev, "Cannot enable vref regulator\n");
>                         return ret;
>                 }
> +               ret = devm_add_action_or_reset(&spi->dev, adc108s102_reg_disable,
> +                                              st->reg);
> +               if (ret)
> +                       return ret;
>
>                 ret = regulator_get_voltage(st->reg);
>                 if (ret < 0) {
> @@ -249,7 +258,6 @@ static int adc108s102_probe(struct spi_device *spi)
>                 st->va_millivolt = ret / 1000;
>         }
>
> -       spi_set_drvdata(spi, indio_dev);
>         st->spi = spi;
>
>         indio_dev->name = spi->modalias;
> @@ -266,40 +274,18 @@ static int adc108s102_probe(struct spi_device *spi)
>         spi_message_init_with_transfers(&st->scan_single_msg,
>                                         &st->scan_single_xfer, 1);
>
> -       ret = iio_triggered_buffer_setup(indio_dev, NULL,
> -                                        &adc108s102_trigger_handler, NULL);
> +       ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
> +                                             &adc108s102_trigger_handler,
> +                                             NULL);
>         if (ret)
> -               goto error_disable_reg;
> +               return ret;
>
> -       ret = iio_device_register(indio_dev);
> -       if (ret) {
> +       ret = devm_iio_device_register(&spi->dev, indio_dev);
> +       if (ret)
>                 dev_err(&spi->dev, "Failed to register IIO device\n");
> -               goto error_cleanup_triggered_buffer;
> -       }
> -       return 0;
> -
> -error_cleanup_triggered_buffer:
> -       iio_triggered_buffer_cleanup(indio_dev);
> -
> -error_disable_reg:
> -       regulator_disable(st->reg);
> -
>         return ret;
>  }
>
> -static int adc108s102_remove(struct spi_device *spi)
> -{
> -       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -       struct adc108s102_state *st = iio_priv(indio_dev);
> -
> -       iio_device_unregister(indio_dev);
> -       iio_triggered_buffer_cleanup(indio_dev);
> -
> -       regulator_disable(st->reg);
> -
> -       return 0;
> -}
> -
>  static const struct of_device_id adc108s102_of_match[] = {
>         { .compatible = "ti,adc108s102" },
>         { }
> @@ -327,7 +313,6 @@ static struct spi_driver adc108s102_driver = {
>                 .acpi_match_table = ACPI_PTR(adc108s102_acpi_ids),
>         },
>         .probe          = adc108s102_probe,
> -       .remove         = adc108s102_remove,
>         .id_table       = adc108s102_id,
>  };
>  module_spi_driver(adc108s102_driver);
> --
> 2.31.1
>
