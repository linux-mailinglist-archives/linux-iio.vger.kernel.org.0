Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D251382553
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 09:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbhEQHaa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 03:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbhEQHa2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 03:30:28 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A91D1C061573
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:29:10 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id s15so2637181vsi.4
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdSr5/mQ8gnf0SD+zRSvkS6htDfU+9UXj7SJ0/y0+BM=;
        b=ZuGI9QdLNqnCJeZWyP0VOKsZfTFa3TweAPuV8You6KwOMhs3QkKtKPrQ17SqMzf82Y
         ZZhuaAMuWGuFP9pwidIyEywVE9GEREVeRnhH8o5npierFS7uF3PBRDgBUhO+D7oMd/ZE
         s+XK/KVP926yYXWAmtdBvOqmqvLwjo4enpR5m45GCb7SFCbdQOS9g/MgMlKvbv6gVnjk
         Zz26RiVrxG8DTbx9Ai9/JOXrJsQYja2Udy/w1ZGWOrSziiLryUvO5kUrjBiI0WetR9en
         wBtIJarOSOw1rnOlSDyseEgJv1bZpBw4Xl3hzbNPUDbBopIAUbiEDSiFWdPS9p9EQxKt
         RR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdSr5/mQ8gnf0SD+zRSvkS6htDfU+9UXj7SJ0/y0+BM=;
        b=Qb8CpQMGBA67kyAynHhLV5D3Ip8wpSX8O6l16eAo2rh3/JTx7aJORnhXqmywqgY/9w
         +nVQTd+47fq3pa4YPnqBye3yGdBQOLcmXmA5MXUBqoZMhGxIGBRKv8sMlS1WbVP3rdhn
         W+TxmqDL31MvbOLtN5NPUg45R5BiBWAjLrpxxEygKtgEzFg5wfScqa3fScXH29J4tOU1
         8EihQLAd6E0Ew3CuwiVBukNIj20qcGFS5rmraUErcomENFACvwe20Ugcik3FomERnfBW
         Q+6Werq+YiOCI1XUiq4nf58uA4fxWrQANwlShYFsOjOeRlWJWK9CcQ3IHRldjgN2T40z
         TwEg==
X-Gm-Message-State: AOAM530OSSsQTu4/48R/RPnodzJ4uT9yGoRwGHnqVdeGRbEpZakts6iT
        c4j1h9eb2YPa60juy5vtmK5m7zP9C4UNsJlvcksxCiuFW3UWQUI0gD0=
X-Google-Smtp-Source: ABdhPJycTb3NK938iG5kuC5mywGIJkh7r36vB5xUrjaQ2CtCYA2KE0MdT9GO8gjHYKIJR39mX0rXZrlbjggF1wJ04T8=
X-Received: by 2002:a67:7d85:: with SMTP id y127mr5521149vsc.43.1621236549969;
 Mon, 17 May 2021 00:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210516172520.1398835-1-jic23@kernel.org> <20210516172520.1398835-7-jic23@kernel.org>
In-Reply-To: <20210516172520.1398835-7-jic23@kernel.org>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 17 May 2021 10:28:59 +0300
Message-ID: <CAASAkob2k-BKWX5d9dD0smtCEEL2_xssDU=uSu8+YOV6qj+DnA@mail.gmail.com>
Subject: Re: [PATCH 6/8] iio: adc: ti-adc0832: Use devm managed functions for
 all of probe()
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
> Simplifies error handling, plus allows us to drop the remove()
> function entirely.
>

Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Akinobu Mita <akinobu.mita@gmail.com>
> ---
>  drivers/iio/adc/ti-adc0832.c | 39 +++++++++++-------------------------
>  1 file changed, 12 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-adc0832.c b/drivers/iio/adc/ti-adc0832.c
> index 0261b3cfc92b..fb5e72600b96 100644
> --- a/drivers/iio/adc/ti-adc0832.c
> +++ b/drivers/iio/adc/ti-adc0832.c
> @@ -236,6 +236,11 @@ static irqreturn_t adc0832_trigger_handler(int irq, void *p)
>         return IRQ_HANDLED;
>  }
>
> +static void adc0832_reg_disable(void *reg)
> +{
> +       regulator_disable(reg);
> +}
> +
>  static int adc0832_probe(struct spi_device *spi)
>  {
>         struct iio_dev *indio_dev;
> @@ -287,36 +292,17 @@ static int adc0832_probe(struct spi_device *spi)
>         if (ret)
>                 return ret;
>
> -       spi_set_drvdata(spi, indio_dev);
> -
> -       ret = iio_triggered_buffer_setup(indio_dev, NULL,
> -                                        adc0832_trigger_handler, NULL);
> +       ret = devm_add_action_or_reset(&spi->dev, adc0832_reg_disable,
> +                                      adc->reg);
>         if (ret)
> -               goto err_reg_disable;
> +               return ret;
>
> -       ret = iio_device_register(indio_dev);
> +       ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
> +                                             adc0832_trigger_handler, NULL);
>         if (ret)
> -               goto err_buffer_cleanup;
> -
> -       return 0;
> -err_buffer_cleanup:
> -       iio_triggered_buffer_cleanup(indio_dev);
> -err_reg_disable:
> -       regulator_disable(adc->reg);
> -
> -       return ret;
> -}
> -
> -static int adc0832_remove(struct spi_device *spi)
> -{
> -       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -       struct adc0832 *adc = iio_priv(indio_dev);
> -
> -       iio_device_unregister(indio_dev);
> -       iio_triggered_buffer_cleanup(indio_dev);
> -       regulator_disable(adc->reg);
> +               return ret;
>
> -       return 0;
> +       return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>
>  static const struct of_device_id adc0832_dt_ids[] = {
> @@ -343,7 +329,6 @@ static struct spi_driver adc0832_driver = {
>                 .of_match_table = adc0832_dt_ids,
>         },
>         .probe = adc0832_probe,
> -       .remove = adc0832_remove,
>         .id_table = adc0832_id,
>  };
>  module_spi_driver(adc0832_driver);
> --
> 2.31.1
>
