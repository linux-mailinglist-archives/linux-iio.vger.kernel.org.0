Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC95481FA6
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 17:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbfHEPAO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 11:00:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36094 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729096AbfHEPAO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 11:00:14 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 799C7216B7;
        Mon,  5 Aug 2019 15:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565017213;
        bh=fNqoiy0quJ5TPZdDDvIWJeaHJHmhY3MqT+YiSJJhko8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=efscdxrnxbPf98iyR+rExwqZFAOudZSp3AISz45tHl+HolzS+E7n4M+IkQUotJ8DP
         UqEdvh4gisGLK/efn78dp2A+XFVRB+HN2K538uKfO1FjqwrZGwfngIFYi88F9eZZO3
         9exMoq6Fpvbwcm9SGE9EqGNIPgTQlo1ua9fEFzg8=
Date:   Mon, 5 Aug 2019 16:00:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 19/57] iio: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190805160008.507e1868@archlinux>
In-Reply-To: <20190730181557.90391-20-swboyd@chromium.org>
References: <20190730181557.90391-1-swboyd@chromium.org>
        <20190730181557.90391-20-swboyd@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 30 Jul 2019 11:15:19 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> We don't need dev_err() messages when platform_get_irq() fails now that
> platform_get_irq() prints an error message itself when something goes
> wrong. Let's remove these prints with a simple semantic patch.
> 
> // <smpl>
> @@
> expression ret;
> struct platform_device *E;
> @@
> 
> ret =
> (
> platform_get_irq(E, ...)
> |
> platform_get_irq_byname(E, ...)
> );
> 
> if ( \( ret < 0 \| ret <= 0 \) )
> {
> (
> -if (ret != -EPROBE_DEFER)
> -{ ...
> -dev_err(...);
> -... }
> |
> ...
> -dev_err(...);
> )
> ...
> }
> // </smpl>
> 
> While we're here, remove braces on if statements that only have one
> statement (manually).
> 
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: linux-iio@vger.kernel.org
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>

Some fuzz due to other changes which is inevitable when a patch
touches large numbers of drivers.  Anyhow, nothing complex so fixed
up and applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> Please apply directly to subsystem trees
> 
>  drivers/iio/adc/ad7606_par.c        | 4 +---
>  drivers/iio/adc/at91_adc.c          | 4 +---
>  drivers/iio/adc/axp288_adc.c        | 4 +---
>  drivers/iio/adc/bcm_iproc_adc.c     | 7 ++-----
>  drivers/iio/adc/da9150-gpadc.c      | 4 +---
>  drivers/iio/adc/envelope-detector.c | 5 +----
>  drivers/iio/adc/exynos_adc.c        | 4 +---
>  drivers/iio/adc/fsl-imx25-gcq.c     | 1 -
>  drivers/iio/adc/imx7d_adc.c         | 4 +---
>  drivers/iio/adc/lpc32xx_adc.c       | 4 +---
>  drivers/iio/adc/npcm_adc.c          | 1 -
>  drivers/iio/adc/rockchip_saradc.c   | 4 +---
>  drivers/iio/adc/sc27xx_adc.c        | 4 +---
>  drivers/iio/adc/spear_adc.c         | 1 -
>  drivers/iio/adc/stm32-adc-core.c    | 1 -
>  drivers/iio/adc/stm32-adc.c         | 4 +---
>  drivers/iio/adc/stm32-dfsdm-adc.c   | 5 +----
>  drivers/iio/adc/sun4i-gpadc-iio.c   | 4 +---
>  drivers/iio/adc/twl6030-gpadc.c     | 4 +---
>  drivers/iio/adc/vf610_adc.c         | 4 +---
>  20 files changed, 17 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606_par.c b/drivers/iio/adc/ad7606_par.c
> index 1b08028facde..f732b3ac7878 100644
> --- a/drivers/iio/adc/ad7606_par.c
> +++ b/drivers/iio/adc/ad7606_par.c
> @@ -53,10 +53,8 @@ static int ad7606_par_probe(struct platform_device *pdev)
>  	int irq;
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "no irq: %d\n", irq);
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	addr = devm_ioremap_resource(&pdev->dev, res);
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 32f1c4a33b20..abe99856c823 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -1179,10 +1179,8 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	idev->info = &at91_adc_info;
>  
>  	st->irq = platform_get_irq(pdev, 0);
> -	if (st->irq < 0) {
> -		dev_err(&pdev->dev, "No IRQ ID is designated\n");
> +	if (st->irq < 0)
>  		return -ENODEV;
> -	}
>  
>  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  
> diff --git a/drivers/iio/adc/axp288_adc.c b/drivers/iio/adc/axp288_adc.c
> index 31d51bcc5f2c..adc9cf7a075d 100644
> --- a/drivers/iio/adc/axp288_adc.c
> +++ b/drivers/iio/adc/axp288_adc.c
> @@ -225,10 +225,8 @@ static int axp288_adc_probe(struct platform_device *pdev)
>  
>  	info = iio_priv(indio_dev);
>  	info->irq = platform_get_irq(pdev, 0);
> -	if (info->irq < 0) {
> -		dev_err(&pdev->dev, "no irq resource?\n");
> +	if (info->irq < 0)
>  		return info->irq;
> -	}
>  	platform_set_drvdata(pdev, indio_dev);
>  	info->regmap = axp20x->regmap;
>  	/*
> diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> index c46c0aa15376..646ebdc0a8b4 100644
> --- a/drivers/iio/adc/bcm_iproc_adc.c
> +++ b/drivers/iio/adc/bcm_iproc_adc.c
> @@ -540,11 +540,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	adc_priv->irqno = platform_get_irq(pdev, 0);
> -	if (adc_priv->irqno <= 0) {
> -		dev_err(&pdev->dev, "platform_get_irq failed\n");
> -		ret = -ENODEV;
> -		return ret;
> -	}
> +	if (adc_priv->irqno <= 0)
> +		return -ENODEV;
>  
>  	ret = regmap_update_bits(adc_priv->regmap, IPROC_REGCTL2,
>  				IPROC_ADC_AUXIN_SCAN_ENA, 0);
> diff --git a/drivers/iio/adc/da9150-gpadc.c b/drivers/iio/adc/da9150-gpadc.c
> index 354433996101..ae8bcc32f63d 100644
> --- a/drivers/iio/adc/da9150-gpadc.c
> +++ b/drivers/iio/adc/da9150-gpadc.c
> @@ -337,10 +337,8 @@ static int da9150_gpadc_probe(struct platform_device *pdev)
>  	init_completion(&gpadc->complete);
>  
>  	irq = platform_get_irq_byname(pdev, "GPADC");
> -	if (irq < 0) {
> -		dev_err(dev, "Failed to get IRQ: %d\n", irq);
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	ret = devm_request_threaded_irq(dev, irq, NULL, da9150_gpadc_irq,
>  					IRQF_ONESHOT, "GPADC", gpadc);
> diff --git a/drivers/iio/adc/envelope-detector.c b/drivers/iio/adc/envelope-detector.c
> index 2f2b563c1162..28f3d6758eb5 100644
> --- a/drivers/iio/adc/envelope-detector.c
> +++ b/drivers/iio/adc/envelope-detector.c
> @@ -357,11 +357,8 @@ static int envelope_detector_probe(struct platform_device *pdev)
>  	}
>  
>  	env->comp_irq = platform_get_irq_byname(pdev, "comp");
> -	if (env->comp_irq < 0) {
> -		if (env->comp_irq != -EPROBE_DEFER)
> -			dev_err(dev, "failed to get compare interrupt\n");
> +	if (env->comp_irq < 0)
>  		return env->comp_irq;
> -	}
>  
>  	ret = devm_request_irq(dev, env->comp_irq, envelope_detector_comp_isr,
>  			       0, "envelope-detector", env);
> diff --git a/drivers/iio/adc/exynos_adc.c b/drivers/iio/adc/exynos_adc.c
> index d4c3ece21679..42a3ced11fbd 100644
> --- a/drivers/iio/adc/exynos_adc.c
> +++ b/drivers/iio/adc/exynos_adc.c
> @@ -805,10 +805,8 @@ static int exynos_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "no irq resource?\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>  	info->irq = irq;
>  
>  	irq = platform_get_irq(pdev, 1);
> diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> index df19ecae52f7..fa71489195c6 100644
> --- a/drivers/iio/adc/fsl-imx25-gcq.c
> +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> @@ -340,7 +340,6 @@ static int mx25_gcq_probe(struct platform_device *pdev)
>  
>  	priv->irq = platform_get_irq(pdev, 0);
>  	if (priv->irq <= 0) {
> -		dev_err(dev, "Failed to get IRQ\n");
>  		ret = priv->irq;
>  		if (!ret)
>  			ret = -ENXIO;
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index 26a7bbe4d534..2a2fbf788e95 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -492,10 +492,8 @@ static int imx7d_adc_probe(struct platform_device *pdev)
>  		return PTR_ERR(info->regs);
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(dev, "No irq resource?\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	info->clk = devm_clk_get(dev, "adc");
>  	if (IS_ERR(info->clk)) {
> diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> index a6ee1c3a9064..b896f7ff4572 100644
> --- a/drivers/iio/adc/lpc32xx_adc.c
> +++ b/drivers/iio/adc/lpc32xx_adc.c
> @@ -172,10 +172,8 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		dev_err(&pdev->dev, "failed getting interrupt resource\n");
> +	if (irq <= 0)
>  		return -ENXIO;
> -	}
>  
>  	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
>  				  LPC32XXAD_NAME, st);
> diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
> index 193b3b81de4d..910f3585fa54 100644
> --- a/drivers/iio/adc/npcm_adc.c
> +++ b/drivers/iio/adc/npcm_adc.c
> @@ -225,7 +225,6 @@ static int npcm_adc_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq <= 0) {
> -		dev_err(dev, "failed getting interrupt resource\n");
>  		ret = -EINVAL;
>  		goto err_disable_clk;
>  	}
> diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
> index dd8299831e09..582ba047c4a6 100644
> --- a/drivers/iio/adc/rockchip_saradc.c
> +++ b/drivers/iio/adc/rockchip_saradc.c
> @@ -244,10 +244,8 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
>  	init_completion(&info->completion);
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "no irq resource?\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	ret = devm_request_irq(&pdev->dev, irq, rockchip_saradc_isr,
>  			       0, dev_name(&pdev->dev), info);
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index f7f7a18904b4..bb616aa01f4f 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -528,10 +528,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	sc27xx_data->irq = platform_get_irq(pdev, 0);
> -	if (sc27xx_data->irq < 0) {
> -		dev_err(&pdev->dev, "failed to get ADC irq number\n");
> +	if (sc27xx_data->irq < 0)
>  		return sc27xx_data->irq;
> -	}
>  
>  	ret = of_hwspin_lock_get_id(np, 0);
>  	if (ret < 0) {
> diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
> index a33d0a4cc088..592b97c464da 100644
> --- a/drivers/iio/adc/spear_adc.c
> +++ b/drivers/iio/adc/spear_adc.c
> @@ -301,7 +301,6 @@ static int spear_adc_probe(struct platform_device *pdev)
>  
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq <= 0) {
> -		dev_err(dev, "failed getting interrupt resource\n");
>  		ret = -EINVAL;
>  		goto errout2;
>  	}
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 1f7ce5186dfc..da292d2e424e 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -349,7 +349,6 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
>  			 */
>  			if (i && priv->irq[i] == -ENXIO)
>  				continue;
> -			dev_err(&pdev->dev, "failed to get irq\n");
>  
>  			return priv->irq[i];
>  		}
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 205e1699f954..6a7dd08b1e0b 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1919,10 +1919,8 @@ static int stm32_adc_probe(struct platform_device *pdev)
>  	}
>  
>  	adc->irq = platform_get_irq(pdev, 0);
> -	if (adc->irq < 0) {
> -		dev_err(&pdev->dev, "failed to get irq\n");
> +	if (adc->irq < 0)
>  		return adc->irq;
> -	}
>  
>  	ret = devm_request_irq(&pdev->dev, adc->irq, stm32_adc_isr,
>  			       0, pdev->name, adc);
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index ee1e0569d0e1..e493242c266e 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1601,11 +1601,8 @@ static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
>  	 * So IRQ associated to filter instance 0 is dedicated to the Filter 0.
>  	 */
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		if (irq != -EPROBE_DEFER)
> -			dev_err(dev, "Failed to get IRQ: %d\n", irq);
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	ret = devm_request_irq(dev, irq, stm32_dfsdm_irq,
>  			       0, pdev->name, adc);
> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
> index f13c6248a662..176e1cb4abb1 100644
> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
> @@ -460,10 +460,8 @@ static int sun4i_irq_init(struct platform_device *pdev, const char *name,
>  	atomic_set(atomic, 1);
>  
>  	ret = platform_get_irq_byname(pdev, name);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "no %s interrupt registered\n", name);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	ret = regmap_irq_get_virq(mfd_dev->regmap_irqc, ret);
>  	if (ret < 0) {
> diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
> index 2fa6ec83bb13..f24148bd15de 100644
> --- a/drivers/iio/adc/twl6030-gpadc.c
> +++ b/drivers/iio/adc/twl6030-gpadc.c
> @@ -905,10 +905,8 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
>  	}
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "failed to get irq\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	ret = devm_request_threaded_irq(dev, irq, NULL,
>  				twl6030_gpadc_irq_handler,
> diff --git a/drivers/iio/adc/vf610_adc.c b/drivers/iio/adc/vf610_adc.c
> index 41d3621c4787..98b30475bbc6 100644
> --- a/drivers/iio/adc/vf610_adc.c
> +++ b/drivers/iio/adc/vf610_adc.c
> @@ -821,10 +821,8 @@ static int vf610_adc_probe(struct platform_device *pdev)
>  		return PTR_ERR(info->regs);
>  
>  	irq = platform_get_irq(pdev, 0);
> -	if (irq < 0) {
> -		dev_err(&pdev->dev, "no irq resource?\n");
> +	if (irq < 0)
>  		return irq;
> -	}
>  
>  	ret = devm_request_irq(info->dev, irq,
>  				vf610_adc_isr, 0,

