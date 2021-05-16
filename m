Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B57593820C1
	for <lists+linux-iio@lfdr.de>; Sun, 16 May 2021 22:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbhEPUFa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 16 May 2021 16:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbhEPUF3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 May 2021 16:05:29 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E51C061573
        for <linux-iio@vger.kernel.org>; Sun, 16 May 2021 13:04:13 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e10so2628355ilu.11
        for <linux-iio@vger.kernel.org>; Sun, 16 May 2021 13:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=konsulko.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3h26JW3U1xLVKDV0Hbe1eijBj2Q0JdkvvSXaA/KJXIU=;
        b=X79w+CfiLBiW743tARmeTNeum8cec4iZjocPOlSytkdJ512QEphI7RtOZSC0QvxSiT
         nTyjxOyq4LhEeyoMttJfsH22nA5uboo55RVTszAWdTBl6iKNNLcyIbk2GfAM+X+CQzRi
         usGgaePiQhsix0ztmZSY2PutF1ZQVLjFjNAb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3h26JW3U1xLVKDV0Hbe1eijBj2Q0JdkvvSXaA/KJXIU=;
        b=hdISpbLLjQmi41RqTi3T5v/2LXbm7FqEvbfo2nPQ58ejQI+oq6e2v2lZxT5ry3sOAt
         lQ560aXpBjE7XvoRNym8geSmDY6RZ3zCjMSu6DOH1VpggXgGr3k8/5XXTWZON7JZvMus
         47h+yl1B8IDKhDm2KxYcO1JP5+Gxd8RrK8Nc/XKpDw1rVHQ67pkSyfMtc6GV+a10b3MG
         707zOC0EveNVwe0sSdSuxjUIMVX+Xe3iBvQu4RhzXHS3mq1e3s6nX+5RTXUAgurdUVIR
         ZpXKg3La55WADNJE8T1QwJYpqTm0lj9TPBzbJHMykWItMReIwd0EEmJwk/9HDUpaOEu/
         RbTQ==
X-Gm-Message-State: AOAM531KdTRC0HvMjTSFVd3ocqLNc/0xurqJUPwxTqpqOr9XRgsGQJKo
        71QiU/sOY9KoSxhIPuGI6J4HNxlm9IS+UAFm7YM1HQ==
X-Google-Smtp-Source: ABdhPJz7amT9ka3OIQrBm1FivnBsIEjGvRLf+quNWTIFdd40ApEnvywrnLHdNPui3hnl+ngv5QKc6+IVZtD9OZkd7oE=
X-Received: by 2002:a05:6e02:1c87:: with SMTP id w7mr3589079ill.25.1621195452929;
 Sun, 16 May 2021 13:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210516172520.1398835-1-jic23@kernel.org> <20210516172520.1398835-9-jic23@kernel.org>
In-Reply-To: <20210516172520.1398835-9-jic23@kernel.org>
From:   Matt Ranostay <matt.ranostay@konsulko.com>
Date:   Sun, 16 May 2021 13:04:01 -0700
Message-ID: <CAJCx=g=ayqnZBY0ymwUkKu1GwWmRUaAJ-YxpvGCZh9CR+q+k4A@mail.gmail.com>
Subject: Re: [PATCH 8/8] iio: adc: ti-adc161s626: Use devm managed functions
 for all of probe.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, May 16, 2021 at 10:26 AM Jonathan Cameron <jic23@kernel.org> wrote:
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
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Matt Ranostay <matt.ranostay@konsulko.com>

Acked-by: Matt Ranostay <matt.ranostay@konsulko.com>

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
