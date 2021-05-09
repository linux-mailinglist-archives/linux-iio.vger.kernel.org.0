Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468373775C8
	for <lists+linux-iio@lfdr.de>; Sun,  9 May 2021 09:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbhEIHbX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 May 2021 03:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhEIHbW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 May 2021 03:31:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E41EC061573
        for <linux-iio@vger.kernel.org>; Sun,  9 May 2021 00:30:17 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id t2-20020a17090ae502b029015b0fbfbc50so8372964pjy.3
        for <linux-iio@vger.kernel.org>; Sun, 09 May 2021 00:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8gNZn97UXont1Xx2f9CE8rymOYunMOOeLiqKittNA1w=;
        b=dVK6LZnaBfmcLg29vS4ISGDAVjtU5KHvzk5W7WWPos9njuSefgsJcH/i7S+WbkD0tS
         xRHUM7gFIJ5w5S4qar/aMOW53zofsW8ei16iZ4r6nq+raA6o7F5Wr5PB/2Szgrrc0Drf
         Wb3FSPkxvg9DnL6No7zlUKcTYAXp2Ipls7UX9c+emu2tc+TsJseGyBe+T0W6FTNHhlzP
         9C+Xh3R6v+6IxE8NAmmScE0NrzDNMM4WiombTDlTVOfYBWx49ThqkWrkRXWp1BxuZJLY
         IkdctpcxQkuxEy9gP5j4sd/7wNOB2yY/A9RJ/LvGWArqVI2OfaWp4kcSDAkWR+2IMwFI
         aOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8gNZn97UXont1Xx2f9CE8rymOYunMOOeLiqKittNA1w=;
        b=B1Ona/LGodsLlLHjK8gHD5gbdP8LPaIsS9fUNND516tElgq7RYKy1A7qHFiEdFNGVJ
         eVVOudIBK237zaLXH3C4l+tRbCyUXeaYqM6S3C6IYygaNHrbsT/ZoyxCd9Tq/CNv/nD1
         UEuzd2nPavjF2agrsSHU7xUXACpYAtVjJ4RJ1L28JKy3xYUaxSELyfnkm3p96BNlSG6w
         uAjniPUMPL6uMs1Q2X6TvGOZe/ID/Ee90vQfeYQnAtpXw4C8u/8n77jgG4HOXIiKkTFv
         cZQOkjamprKVi3aJs7gW+2/h5UH2OuhYd7+uysk/q0k0NwfmmsHcGLCbEv9di8d+0joF
         +6IA==
X-Gm-Message-State: AOAM5318Qz5vvqyBTODTByW1p1/3OTkLJZ5RZrpYtVuBFQKYNbAsLKwN
        cR3xxy8ciJCfQkzrJuS1Ci5gZi517g4ZgFm6tV0=
X-Google-Smtp-Source: ABdhPJySw9BJbP+mRJrshxqx2DHOvsaL70WgmaNhboXcXtE41/abVFfpuDOO2xDDZ2vl124ppDtC+vXn0J15pCBtL6E=
X-Received: by 2002:a17:90a:1b0b:: with SMTP id q11mr21135590pjq.181.1620545416971;
 Sun, 09 May 2021 00:30:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210508182319.488551-1-jic23@kernel.org> <20210508182319.488551-4-jic23@kernel.org>
In-Reply-To: <20210508182319.488551-4-jic23@kernel.org>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Sun, 9 May 2021 10:30:05 +0300
Message-ID: <CA+U=DsrC74AjA6VeJAA+C2=LWZ6FttLSKLt5mOJGMouTb45NrA@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: ad7124: Use devm_ managed calls for all of
 probe() + drop remove()
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        alexandru.tachici@analog.com,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 8, 2021 at 9:24 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> As not many steps were not already devm_ managed, use
> devm_add_action_or_reset() to handle the rest.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Cc: Alexandru Ardelean <ardeleanalex@gmail.com>

double Cc: tag here

One minor thought about maybe removing the log spam.
Other than that:

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>


> ---
>  drivers/iio/adc/ad7124.c | 53 ++++++++++++++++++----------------------
>  1 file changed, 24 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
> index 9c2401c5848e..deb166d2b645 100644
> --- a/drivers/iio/adc/ad7124.c
> +++ b/drivers/iio/adc/ad7124.c
> @@ -719,6 +719,16 @@ static void ad7124_reg_disable(void *r)
>         regulator_disable(r);
>  }
>
> +static void ad7124_clk_disable(void *c)
> +{
> +       clk_disable_unprepare(c);
> +}
> +
> +static void ad7124_buffer_cleanup(void *idev)
> +{
> +       ad_sd_cleanup_buffer_and_trigger(idev);

We never seem to have done a devm_ version for ad_sd_setup_buffer_and_trigger().


> +}
> +
>  static int ad7124_probe(struct spi_device *spi)
>  {
>         const struct ad7124_chip_info *info;
> @@ -740,8 +750,6 @@ static int ad7124_probe(struct spi_device *spi)
>
>         ad_sd_init(&st->sd, indio_dev, spi, &ad7124_sigma_delta_info);
>
> -       spi_set_drvdata(spi, indio_dev);
> -
>         indio_dev->name = st->chip_info->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &ad7124_info;
> @@ -779,48 +787,36 @@ static int ad7124_probe(struct spi_device *spi)
>         if (ret < 0)
>                 return ret;
>
> +       ret = devm_add_action_or_reset(&spi->dev, ad7124_clk_disable, st->mclk);
> +       if (ret)
> +               return ret;
> +
>         ret = ad7124_soft_reset(st);
>         if (ret < 0)
> -               goto error_clk_disable_unprepare;
> +               return ret;
>
>         ret = ad7124_check_chip_id(st);
>         if (ret)
> -               goto error_clk_disable_unprepare;
> +               return ret;
>
>         ret = ad7124_setup(st);
>         if (ret < 0)
> -               goto error_clk_disable_unprepare;
> +               return ret;
>
>         ret = ad_sd_setup_buffer_and_trigger(indio_dev);
>         if (ret < 0)
> -               goto error_clk_disable_unprepare;
> -
> -       ret = iio_device_register(indio_dev);
> -       if (ret < 0) {
> -               dev_err(&spi->dev, "Failed to register iio device\n");
> -               goto error_remove_trigger;
> -       }
> +               return ret;
>
> -       return 0;
> +       ret = devm_add_action_or_reset(&spi->dev, ad7124_buffer_cleanup, indio_dev);
> +       if (ret)
> +               return ret;
>
> -error_remove_trigger:
> -       ad_sd_cleanup_buffer_and_trigger(indio_dev);
> -error_clk_disable_unprepare:
> -       clk_disable_unprepare(st->mclk);
> +       ret = devm_iio_device_register(&spi->dev, indio_dev);
> +       if (ret)
> +               dev_err(&spi->dev, "Failed to register iio device\n");

I guess Andy may come along and suggest that we remove this log spam
and just do a direct return.
Which would sound like a reasonable idea.

>
>         return ret;
> -}
>
> -static int ad7124_remove(struct spi_device *spi)
> -{
> -       struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -       struct ad7124_state *st = iio_priv(indio_dev);
> -
> -       iio_device_unregister(indio_dev);
> -       ad_sd_cleanup_buffer_and_trigger(indio_dev);
> -       clk_disable_unprepare(st->mclk);
> -
> -       return 0;
>  }
>
>  static const struct of_device_id ad7124_of_match[] = {
> @@ -838,7 +834,6 @@ static struct spi_driver ad71124_driver = {
>                 .of_match_table = ad7124_of_match,
>         },
>         .probe = ad7124_probe,
> -       .remove = ad7124_remove,
>  };
>  module_spi_driver(ad71124_driver);
>
> --
> 2.31.1
>
