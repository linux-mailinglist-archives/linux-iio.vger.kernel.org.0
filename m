Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D64E254F59
	for <lists+linux-iio@lfdr.de>; Thu, 27 Aug 2020 21:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726246AbgH0Tvd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 27 Aug 2020 15:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbgH0Tvc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 27 Aug 2020 15:51:32 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3831C061264;
        Thu, 27 Aug 2020 12:51:31 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so4319475pfn.5;
        Thu, 27 Aug 2020 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gcd1nB19OTH1zKv6qhSqc5xobRaHVee78g1PzbEl6fI=;
        b=ex/gpgjovMoKhy+gwxNUzVmwdddR+jvZu5aH2FiNpjTquN08Wii0oVRnzjAILdzc7M
         0bmTucnzTPnopfTBGMk80abYdFtN69xKYbokxYZKljcp18CujGDWVFUIQ6npTqta0xzD
         2Crf7GPhGLOOpwZDpCbQtsDRqjAEyhwlO4xV0UbLnTA02CJwXm9JiZs05MEVbs1c/4eT
         QfQssqJBixDV7Sp7cxuZJgGJzU9S/uHgB8g++h6p/qJWBKpK2+z8B215WH4hxRDVJkQa
         EjuT59THU9Een7KH8ca9JDOmfxqbYYQQj8re2bgrC+uMbxy9tZMrJuIP0+X8iOzyV3xJ
         kchA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gcd1nB19OTH1zKv6qhSqc5xobRaHVee78g1PzbEl6fI=;
        b=qAmzbwQRo4pPXu2znHZ9sdW/1AjluOriFuCVjeYrhH2ly6Idj8yxEkYzQTHOFSm+oW
         tnNzIEamJNz74aiE4U9mIi+WnvADrCtv2KKTcerp30BqbactKKchk165jhZqg75Apo2z
         3XP6mD6FvtibHz3btl+3IVmBx8YgwhhGSMfFzsRZlVZoZeKdMWVJWD1XW09rGfhx/cuJ
         gbjd8oD5U9v8jOVX6U5QdUj0GutzUpIA3nZx9lge9JThYvde2e/oRpSNrwScTlW908ji
         CQs0oJgQehQWx1Uc+MwNnsq9btQd1wTOtghGZARKM7oAcSZcyL6CG8ztNidcSe4ujl0r
         I78A==
X-Gm-Message-State: AOAM533h4R/getXQQS647Y265CVBKTCO6JzI9z/HAtScTN4lQNJj8fZH
        t+V4EYc0cAb+qVkgA7zsqv6zKc991aoAz8H5YYU=
X-Google-Smtp-Source: ABdhPJygfJzIrG3kwV1/jhIjw8ITN96yhEa6YFN7u9Xjf/ec+8mvoIJ8bbkGi47nXk15GCawUM1CW08gWBIe8YlHpT4=
X-Received: by 2002:a17:902:8208:: with SMTP id x8mr6293153pln.65.1598557891210;
 Thu, 27 Aug 2020 12:51:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200827192642.1725-1-krzk@kernel.org> <20200827192642.1725-8-krzk@kernel.org>
In-Reply-To: <20200827192642.1725-8-krzk@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 27 Aug 2020 22:51:14 +0300
Message-ID: <CAHp75VfhmCBG615xW5XD6m9Fzkbv_3C5LiQCjTjhOAC7yFmE+A@mail.gmail.com>
Subject: Re: [PATCH v2 08/18] iio: adc: stm32: Simplify with dev_err_probe()
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

On Thu, Aug 27, 2020 at 10:28 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> Common pattern of handling deferred probe can be simplified with
> dev_err_probe().  Less code and also it prints the error value.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Convert to devm_clk_get_optional
> 2. Update also stm32-dfsdm-core and stm32-dac-core.
> 3. Wrap around 100 characters (accepted by checkpatch).
> ---
>  drivers/iio/adc/stm32-adc-core.c   | 67 +++++++++---------------------
>  drivers/iio/adc/stm32-adc.c        |  9 +---
>  drivers/iio/adc/stm32-dfsdm-adc.c  |  9 +---
>  drivers/iio/adc/stm32-dfsdm-core.c |  8 +---
>  drivers/iio/dac/stm32-dac-core.c   |  5 +--
>  5 files changed, 26 insertions(+), 72 deletions(-)
>
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 0e2068ec068b..707c85dab7df 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -582,11 +582,9 @@ static int stm32_adc_core_switches_probe(struct device *dev,
>         priv->syscfg = syscon_regmap_lookup_by_phandle(np, "st,syscfg");
>         if (IS_ERR(priv->syscfg)) {
>                 ret = PTR_ERR(priv->syscfg);
> -               if (ret != -ENODEV) {
> -                       if (ret != -EPROBE_DEFER)
> -                               dev_err(dev, "Can't probe syscfg: %d\n", ret);
> -                       return ret;
> -               }
> +               if (ret != -ENODEV)
> +                       return dev_err_probe(dev, ret, "Can't probe syscfg\n");
> +
>                 priv->syscfg = NULL;
>         }
>
> @@ -596,12 +594,9 @@ static int stm32_adc_core_switches_probe(struct device *dev,
>                 priv->booster = devm_regulator_get_optional(dev, "booster");
>                 if (IS_ERR(priv->booster)) {
>                         ret = PTR_ERR(priv->booster);
> -                       if (ret != -ENODEV) {
> -                               if (ret != -EPROBE_DEFER)
> -                                       dev_err(dev, "can't get booster %d\n",
> -                                               ret);
> -                               return ret;
> -                       }
> +                       if (ret != -ENODEV)
> +                               dev_err_probe(dev, ret, "can't get booster\n");
> +
>                         priv->booster = NULL;
>                 }
>         }
> @@ -612,11 +607,9 @@ static int stm32_adc_core_switches_probe(struct device *dev,
>                 priv->vdd = devm_regulator_get_optional(dev, "vdd");
>                 if (IS_ERR(priv->vdd)) {
>                         ret = PTR_ERR(priv->vdd);
> -                       if (ret != -ENODEV) {
> -                               if (ret != -EPROBE_DEFER)
> -                                       dev_err(dev, "can't get vdd %d\n", ret);
> -                               return ret;
> -                       }
> +                       if (ret != -ENODEV)
> +                               return dev_err_probe(dev, ret, "can't get vdd\n");
> +
>                         priv->vdd = NULL;
>                 }
>         }
> @@ -669,42 +662,20 @@ static int stm32_adc_probe(struct platform_device *pdev)
>         priv->common.phys_base = res->start;
>
>         priv->vdda = devm_regulator_get(&pdev->dev, "vdda");
> -       if (IS_ERR(priv->vdda)) {
> -               ret = PTR_ERR(priv->vdda);
> -               if (ret != -EPROBE_DEFER)
> -                       dev_err(&pdev->dev, "vdda get failed, %d\n", ret);
> -               return ret;
> -       }
> +       if (IS_ERR(priv->vdda))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(priv->vdda), "vdda get failed\n");
>
>         priv->vref = devm_regulator_get(&pdev->dev, "vref");
> -       if (IS_ERR(priv->vref)) {
> -               ret = PTR_ERR(priv->vref);
> -               if (ret != -EPROBE_DEFER)
> -                       dev_err(&pdev->dev, "vref get failed, %d\n", ret);
> -               return ret;
> -       }
> +       if (IS_ERR(priv->vref))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(priv->vref), "vref get failed\n");
>
> -       priv->aclk = devm_clk_get(&pdev->dev, "adc");
> -       if (IS_ERR(priv->aclk)) {
> -               ret = PTR_ERR(priv->aclk);
> -               if (ret != -ENOENT) {
> -                       if (ret != -EPROBE_DEFER)
> -                               dev_err(&pdev->dev, "Can't get 'adc' clock\n");
> -                       return ret;
> -               }
> -               priv->aclk = NULL;
> -       }
> +       priv->aclk = devm_clk_get_optional(&pdev->dev, "adc");
> +       if (IS_ERR(priv->aclk))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(priv->aclk), "Can't get 'adc' clock\n");
>
> -       priv->bclk = devm_clk_get(&pdev->dev, "bus");
> -       if (IS_ERR(priv->bclk)) {
> -               ret = PTR_ERR(priv->bclk);
> -               if (ret != -ENOENT) {
> -                       if (ret != -EPROBE_DEFER)
> -                               dev_err(&pdev->dev, "Can't get 'bus' clock\n");
> -                       return ret;
> -               }
> -               priv->bclk = NULL;
> -       }
> +       priv->bclk = devm_clk_get_optional(&pdev->dev, "bus");
> +       if (IS_ERR(priv->bclk))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(priv->bclk), "Can't get 'bus' clock\n");
>
>         ret = stm32_adc_core_switches_probe(dev, priv);
>         if (ret)
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 3eb9ebe8372f..b8e764ca54a6 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1805,13 +1805,8 @@ static int stm32_adc_dma_request(struct device *dev, struct iio_dev *indio_dev)
>         adc->dma_chan = dma_request_chan(dev, "rx");
>         if (IS_ERR(adc->dma_chan)) {
>                 ret = PTR_ERR(adc->dma_chan);
> -               if (ret != -ENODEV) {
> -                       if (ret != -EPROBE_DEFER)
> -                               dev_err(dev,
> -                                       "DMA channel request failed with %d\n",
> -                                       ret);
> -                       return ret;
> -               }
> +               if (ret != -ENODEV)
> +                       return dev_err_probe(dev, ret, "DMA channel request failed with\n");
>
>                 /* DMA is optional: fall back to IRQ mode */
>                 adc->dma_chan = NULL;
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 5e10fb4f3704..12c951078c1f 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1473,13 +1473,8 @@ static int stm32_dfsdm_adc_init(struct device *dev, struct iio_dev *indio_dev)
>         /* Optionally request DMA */
>         ret = stm32_dfsdm_dma_request(dev, indio_dev);
>         if (ret) {
> -               if (ret != -ENODEV) {
> -                       if (ret != -EPROBE_DEFER)
> -                               dev_err(dev,
> -                                       "DMA channel request failed with %d\n",
> -                                       ret);
> -                       return ret;
> -               }
> +               if (ret != -ENODEV)
> +                       return dev_err_probe(dev, ret, "DMA channel request failed with\n");
>
>                 dev_dbg(dev, "No DMA support\n");
>                 return 0;
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index 26e2011c5868..34e4e6e59acf 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -243,12 +243,8 @@ static int stm32_dfsdm_parse_of(struct platform_device *pdev,
>          * on use case.
>          */
>         priv->clk = devm_clk_get(&pdev->dev, "dfsdm");
> -       if (IS_ERR(priv->clk)) {
> -               ret = PTR_ERR(priv->clk);
> -               if (ret != -EPROBE_DEFER)
> -                       dev_err(&pdev->dev, "Failed to get clock (%d)\n", ret);
> -               return ret;
> -       }
> +       if (IS_ERR(priv->clk))
> +               return dev_err_probe(&pdev->dev, PTR_ERR(priv->clk), "Failed to get clock\n");
>
>         priv->aclk = devm_clk_get(&pdev->dev, "audio");
>         if (IS_ERR(priv->aclk))
> diff --git a/drivers/iio/dac/stm32-dac-core.c b/drivers/iio/dac/stm32-dac-core.c
> index 7e5809ba0dee..906436780347 100644
> --- a/drivers/iio/dac/stm32-dac-core.c
> +++ b/drivers/iio/dac/stm32-dac-core.c
> @@ -150,10 +150,7 @@ static int stm32_dac_probe(struct platform_device *pdev)
>         rst = devm_reset_control_get_optional_exclusive(dev, NULL);
>         if (rst) {
>                 if (IS_ERR(rst)) {
> -                       ret = PTR_ERR(rst);
> -                       if (ret != -EPROBE_DEFER)
> -                               dev_err(dev, "reset get failed, %d\n", ret);
> -
> +                       ret = dev_err_probe(dev, PTR_ERR(rst), "reset get failed\n");
>                         goto err_hw_stop;
>                 }
>
> --
> 2.17.1
>


-- 
With Best Regards,
Andy Shevchenko
