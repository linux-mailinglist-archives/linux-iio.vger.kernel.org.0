Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FAE38256F
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 09:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbhEQHgd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 03:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230499AbhEQHgd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 03:36:33 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34239C061573
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:35:16 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id 20so1795412uaf.12
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L5NdTL3UEjWb3XwPdeE9uHNyKuTTqX8S6w+FG76at0k=;
        b=eRWDtnmzeNkKo4nwWz8MJ7Cm6taYUROJQsW9NdjcdNBnTBIV614n6WoVxT8/hPVLed
         DogLAlLQcPZ7OZ5tvgQyy1FPL9DNlTLJzC01qcQpoQ0gbJI/EIDEb7PTekQ850+LQr3v
         cVwFyk9pf+EJf4fdG4OYwNIRN5Sm8ktNHJYVfnSxqOx6A0Ilw2kRGrY3Dyr4EcjtEFBe
         KgCpIgM6csArvUIi18E+p1I9UlpLvD7TisRYFdSKZASwDj+U6MACkHS/xxTRG5dJtrHg
         9swBAAkmrlSEsCU3Rjjs3lsBLo1a/ADeiBl2b5uJ45ZN8FLBvQHdx7cutryoUxnDzCfq
         LA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L5NdTL3UEjWb3XwPdeE9uHNyKuTTqX8S6w+FG76at0k=;
        b=D+oKFF3Bfk5OOEnRSqOsQJa05nXRHXysLMoAB3qWupiAsIMkELtAx7wrBCgfZLWgdL
         g+4QRI4Q9mhvKUi5CM0WLEKXomDt0QJXXF08Vw61/BFAC6Wiv90inqdkd11NXQwo2Cd7
         FHRzWFubBtJ6BwtX8Me7U+h2P6dgd0LEbR8PPAZdst0U4Vqn8deN4I/TNDdljMGGuyi+
         EBqal6EF6+wmqDdu75y29xqjtLjI2H4n0UP16pcSpW8kCzKiLsdnU/QpJT5Tt0uJ6qxl
         mCSQyEKkEvQLDIIQfb3xDnDeFyuYf0PCkgqnLuciQ+EiHeJ6QDi9n7DNoCwf9731uTW+
         xDcA==
X-Gm-Message-State: AOAM530oBBw+K8oUKCx9s77RukDTbtkaBgLvcdImVscmd6BNNGkMlKgL
        z3uTojyyLzl0jicOJsHuEEVpZI+1QW9hs7uZyqWU5A==
X-Google-Smtp-Source: ABdhPJz+j8mCaICU+g9DMfdMt63CtencIRj3W1gDmAXcou9o2zyWci7x5UHjltBl0w7lKt9GEoxeEQOyifUaVT3hl2w=
X-Received: by 2002:ab0:596f:: with SMTP id o44mr51570048uad.8.1621236915364;
 Mon, 17 May 2021 00:35:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210516172520.1398835-1-jic23@kernel.org> <20210516172520.1398835-9-jic23@kernel.org>
In-Reply-To: <20210516172520.1398835-9-jic23@kernel.org>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 17 May 2021 10:35:04 +0300
Message-ID: <CAASAkoam6UcQ+NeY3vUtFQVuQPGEu+Q0ojcjZbnJQrEG3FnmzQ@mail.gmail.com>
Subject: Re: [PATCH 8/8] iio: adc: ti-adc161s626: Use devm managed functions
 for all of probe.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 May 2021 at 20:26, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Simplifies error handling and allows us to drop remove entirely.
>
> The regulator handling in this driver was unusual as it would try to
> acquire the regulator, but if that failed with an error would continue.
>
> We should get a stub regulator if one isn't provided in DT and an error
> could indicate an actual problem preventing the device being powered
> (perhaps a need to defer). So this handling is cleaned up (arguably
> that might be a fix but given no one has run into it, I haven't broken
> it out separately.
>

This patch forgets to remove "spi_set_drvdata(spi, indio_dev);"
With that fixed

Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/adc/ti-adc161s626.c | 50 ++++++++++++---------------------
>  1 file changed, 18 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
> index 607791ffe7f0..9f2f25cf9a49 100644
> --- a/drivers/iio/adc/ti-adc161s626.c
> +++ b/drivers/iio/adc/ti-adc161s626.c
> @@ -169,6 +169,11 @@ static const struct iio_info ti_adc_info = {
>         .read_raw = ti_adc_read_raw,
>  };
>
> +static void ti_adc_reg_disable(void *reg)
> +{
> +       regulator_disable(reg);
> +}
> +
>  static int ti_adc_probe(struct spi_device *spi)
>  {
>         struct iio_dev *indio_dev;
> @@ -203,42 +208,24 @@ static int ti_adc_probe(struct spi_device *spi)
>         }
>
>         data->ref = devm_regulator_get(&spi->dev, "vdda");
> -       if (!IS_ERR(data->ref)) {
> -               ret = regulator_enable(data->ref);
> -               if (ret < 0)
> -                       return ret;
> -       }
> +       if (IS_ERR(data->ref))
> +               return PTR_ERR(data->ref);
>
> -       ret = iio_triggered_buffer_setup(indio_dev, NULL,
> -                                        ti_adc_trigger_handler, NULL);
> -       if (ret)
> -               goto error_regulator_disable;
> +       ret = regulator_enable(data->ref);
> +       if (ret < 0)
> +               return ret;
>
> -       ret = iio_device_register(indio_dev);
> +       ret = devm_add_action_or_reset(&spi->dev, ti_adc_reg_disable,
> +                                      data->ref);
>         if (ret)
> -               goto error_unreg_buffer;
> -
> -       return 0;
> +               return ret;
>
> -error_unreg_buffer:
> -       iio_triggered_buffer_cleanup(indio_dev);
> -
> -error_regulator_disable:
> -       regulator_disable(data->ref);
> -
> -       return ret;
> -}
> -
> -static int ti_adc_remove(struct spi_device *spi)
> -{
> -       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -       struct ti_adc_data *data = iio_priv(indio_dev);
> -
> -       iio_device_unregister(indio_dev);
> -       iio_triggered_buffer_cleanup(indio_dev);
> -       regulator_disable(data->ref);
> +       ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
> +                                             ti_adc_trigger_handler, NULL);
> +       if (ret)
> +               return ret;
>
> -       return 0;
> +       return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>
>  static const struct of_device_id ti_adc_dt_ids[] = {
> @@ -261,7 +248,6 @@ static struct spi_driver ti_adc_driver = {
>                 .of_match_table = ti_adc_dt_ids,
>         },
>         .probe          = ti_adc_probe,
> -       .remove         = ti_adc_remove,
>         .id_table       = ti_adc_id,
>  };
>  module_spi_driver(ti_adc_driver);
> --
> 2.31.1
>
