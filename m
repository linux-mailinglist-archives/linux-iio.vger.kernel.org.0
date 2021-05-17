Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8E382510
	for <lists+linux-iio@lfdr.de>; Mon, 17 May 2021 09:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234429AbhEQHKA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 17 May 2021 03:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbhEQHJu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 17 May 2021 03:09:50 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 307EDC061573
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:08:26 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id f10so215438vkm.12
        for <linux-iio@vger.kernel.org>; Mon, 17 May 2021 00:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OtcZQLMbNF+LjmPC86OqwM8BWNtBhj0oGdYeNwW1IFE=;
        b=rQ6yr/tMp8rcYJRFU8DcLS1uQ+WhrrMJK0i6VDB1Vup55nH2yWmE6zdgMYolf4pNPc
         F4E5G+rfKEBClTG60gpm8SKWc1rAmuIxFiFJFcqkg/Lny5gdb7cYeQ+/BpxB+S2l9tuA
         g/OIBjjCcvlTXl6a6IchVzZt3ZjmK28nY3sCGUBsuRfAg605iNVslLILoW8tkMnyJ60x
         zy8jJ4fHvH/Lw3W/JG00kQ1gftDGd8r5l+dG3EHk+/ATqtRdlDXQqcUVVqsKf6Lwg/B8
         wF5C95pMn6hw3zDftpF3oIeU5xWVArddND9j4wtDaMP3xw97S4XAjq9dZPC7zFGkLmUJ
         CNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OtcZQLMbNF+LjmPC86OqwM8BWNtBhj0oGdYeNwW1IFE=;
        b=IhWMxhnLkVjyxGKVuig7REWitKgzRWQokvzk1+PFCjnnzf35Vvq3pZDNkWeiA4LCyU
         60hYrcHyPrbhh4SEhcd5GFegJMTuTP0B6tTG/6HyhPLfwNIcOUrTjE4bd2jmO02xoFJr
         no0xej2w5UjuFPgLTNL7BJtG+X1py4ybfhvW3h+k5Mj73C3J6+dZAZc80tSAG+1jcDcD
         MTlqkWa3ESQwZy5o3YscGv/V442gstwRKw3iVzmOve6nyzYgeQovWMXGV23C+2dt0e8A
         7EMVDPm+CezgTTt6NXWGelFgEirivk+Yl+FEGedd3LpYWM3mTgJ7Z5qeSPpEYt3leItq
         vTLg==
X-Gm-Message-State: AOAM531qWX0h9GxjHpLJHl16yT9JuGO75SokhJr3nry/q/HeYlcHTyBi
        rbWIUigUZIcPmqXChup8DesGIszaY8CapO2E+Ys52kQpZUMgif/6riE=
X-Google-Smtp-Source: ABdhPJwreJBibQs6Ir82wTOP/VPs4mGXz69o6aFnDmMq1k9oHZ5S885fk8q/QzxgTspFiFsQlMstPP2numTYNauIgc4=
X-Received: by 2002:a1f:4c83:: with SMTP id z125mr42080392vka.11.1621235305479;
 Mon, 17 May 2021 00:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20210516172520.1398835-1-jic23@kernel.org> <20210516172520.1398835-3-jic23@kernel.org>
In-Reply-To: <20210516172520.1398835-3-jic23@kernel.org>
From:   Alexandru Ardelean <aardelean@deviqon.com>
Date:   Mon, 17 May 2021 10:08:14 +0300
Message-ID: <CAASAkoaYcAG8-s5kfd68Hi2m7+JCWhh0gd5yrMN0vO1cESy+uA@mail.gmail.com>
Subject: Re: [PATCH 2/8] iio: adc: max11100: Use devm_ functions for rest of probe()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jacopo Mondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 16 May 2021 at 20:26, Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> By using devm_add_action_or_reset() to manage the regulator disable,
> it becomes simple to use managed functions for all of remove.
> This simplifies error handling and allows us to drop the remove()
> function entirely.
>

Reviewed-by: Alexandru Ardelean <aardelean@deviqon.com>

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Jacopo Mondi <jacopo@jmondi.org>
> ---
>  drivers/iio/adc/max11100.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/iio/adc/max11100.c b/drivers/iio/adc/max11100.c
> index 69d607fa17aa..9951f6a6a4b9 100644
> --- a/drivers/iio/adc/max11100.c
> +++ b/drivers/iio/adc/max11100.c
> @@ -102,6 +102,11 @@ static const struct iio_info max11100_info = {
>         .read_raw = max11100_read_raw,
>  };
>
> +static void max11100_regulator_disable(void *reg)
> +{
> +       regulator_disable(reg);
> +}
> +
>  static int max11100_probe(struct spi_device *spi)
>  {
>         int ret;
> @@ -131,27 +136,12 @@ static int max11100_probe(struct spi_device *spi)
>         if (ret)
>                 return ret;
>
> -       ret = iio_device_register(indio_dev);
> +       ret = devm_add_action_or_reset(&spi->dev, max11100_regulator_disable,
> +                               state->vref_reg);
>         if (ret)
> -               goto disable_regulator;
> -
> -       return 0;
> -
> -disable_regulator:
> -       regulator_disable(state->vref_reg);
> -
> -       return ret;
> -}
> -
> -static int max11100_remove(struct spi_device *spi)
> -{
> -       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -       struct max11100_state *state = iio_priv(indio_dev);
> -
> -       iio_device_unregister(indio_dev);
> -       regulator_disable(state->vref_reg);
> +               return ret;
>
> -       return 0;
> +       return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>
>  static const struct of_device_id max11100_ids[] = {
> @@ -166,7 +156,6 @@ static struct spi_driver max11100_driver = {
>                 .of_match_table = max11100_ids,
>         },
>         .probe          = max11100_probe,
> -       .remove         = max11100_remove,
>  };
>
>  module_spi_driver(max11100_driver);
> --
> 2.31.1
>
