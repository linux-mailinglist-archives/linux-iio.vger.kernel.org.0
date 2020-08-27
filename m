Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E24D6254F18
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgH0TrL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0TrK (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 15:47:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CACDC061264;
        Thu, 27 Aug 2020 12:46:54 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id kx11so3139590pjb.5;
        Thu, 27 Aug 2020 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rF/IVgk4h5+MJuABqXa02sDX7QSYWX1qauCg5n/+jTM=;
        b=TV1dA5Xov0ck9OozRII/ftao8/R/YHMTCO/1WHAIME1O4niFg+OgXtzAY2zjfXEpz3
         e0y6JKc4ubTRQp2/5w0foJUYIoIiuNW4CZ8lovjPOZqrdFroT5QwHYWrBp5yjg1/iO4K
         SVI5qRKlgZYwcEEDVM5YA0sI7csZKPJ2go+y1RjxW6Y47BgMpwAgSmA1F/niu3rX4LJI
         Luhg6tmGDAO8T0kxLUogjDa7/r9vrR6E9YDb+FNA7Bgv3VY5XQqe3DghJZnJPELSU4YQ
         Y2d132gTzXLclulfMER6/ZCCJ+q1KmVWZnuoZuPJmXNmjdAxfrHlY0Y88zQ4nI6ZZMT9
         9/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rF/IVgk4h5+MJuABqXa02sDX7QSYWX1qauCg5n/+jTM=;
        b=EKHn0QuDgQprWoeSAgJQfEjPdf5GDy8/FgeDgbk4SVlYY6Oq9Jlfp6ryQ8GFDytCrm
         Yyo6G96zrurPgoWgXoys1YdErLmeYGDZhrRqYfOV0SyTDsmuMV4L/TzK0Iz+3YoCndJZ
         fZzkt6jvYcZcotgvQXShu6zzwAaYCmT4zyscEK8QQostEj57CtSoQygIyY8Vfy1T2tXo
         BAWEV/yWR6j63yGMiQuUiRUR6z6nVTSAKCh4Rxz4m82ad5d1DDVyfRvxLV7o69NBzGFh
         1iqvO4NBweL0y/OAvBrqplq4YjZ/DQTcLrhMpN5B1Kfg6BZGW7xhwAiL7YnGfBL65D5Q
         Re5A==
X-Gm-Message-State: AOAM532jIs5hrINpxiOJQAyj4FLzGGoOvj++Hqp4LL3iv2TwCkDITYXw
        UmNEaJOBbTv4CglDqmzf9gz+Cba8L1Rjaj/Tuh8=
X-Google-Smtp-Source: ABdhPJz+mPBt1w0ZVF5ot5qjiuaeOhaA9v5A1SLVkElmmTlR8IGArmMT4pz9gEJ+J7LbWY73M9EE9DJ74oGTNNcog7A=
X-Received: by 2002:a17:90b:509:: with SMTP id r9mr410422pjz.228.1598557614008;
 Thu, 27 Aug 2020 12:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-4-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-4-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 22:46:37 +0300
Message-ID: <CAHp75VcKctq6pAw+D5fYMtASGP_NuYOf4GJ+8t=Otxf_RVjKyA@mail.gmail.com>
Subject: Re: [PATCH v2 04/18] iio: adc: exynos_adc: Simplify with dev_err_probe()
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Peter Rosin <peda@axentia.se>, Kukjin Kim <kgene@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Aug 27, 2020 at 10:27 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Wrap dev_err_probe() lines at 100 character
> ---
>  drivers/iio/adc/exynos_adc.c | 9 ++-------
>  1 file changed, 2 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index 7d23b6c33284..40585a96c848 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -844,13 +844,8 @@ static int exynos_adc_probe(struct platform_device *pdev)
>         }
>
>         info->vdd = devm_regulator_get(&pdev->dev, "vdd");
> -       if (IS_ERR(info->vdd)) {
> -               if (PTR_ERR(info->vdd) != -EPROBE_DEFER)
> -                       dev_err(&pdev->dev,
> -                               "failed getting regulator, err = %ld\n",
> -                               PTR_ERR(info->vdd));
> -               return PTR_ERR(info->vdd);
> -       }
> +       if (IS_ERR(info->vdd))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(info->vdd), "failed getting regulator");
>
>         ret = regulator_enable(info->vdd);
>         if (ret)
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
