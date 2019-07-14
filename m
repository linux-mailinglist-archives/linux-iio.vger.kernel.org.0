Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAC967F72
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 16:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728362AbfGNOu6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 10:50:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:52832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728146AbfGNOu6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 10:50:58 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4218E205F4;
        Sun, 14 Jul 2019 14:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563115857;
        bh=8Vy3EmFWn6pgNPzexJDXyBDOHfyJgBlPGs3qDdxFGAc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i70z4zNGWQIKn5nRY4VLY/cYdZX7zfBFYN3fmhD2poFWUxI7IRs1BNeWVyBMPNx0d
         9Rg4tA5d8oa7TtW/dp4d5Yy4c7x3uZ5o4eMrY5OunrBi1AnqQgtIDUx8jJV47qio2d
         hhsnjvkx2+Lc65S0/9Ht3B57S98aiDs61eRZ9xDc=
Date:   Sun, 14 Jul 2019 15:50:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fuqian Huang <huangfq.daxian@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        freeman.liu@spreadtrum.com
Subject: Re: [PATCH 01/14] iio: adc: sc27xx: Introduce local variable
 'struct device *dev'
Message-ID: <20190714155052.5092cf0d@archlinux>
In-Reply-To: <20190708123221.11658-1-huangfq.daxian@gmail.com>
References: <20190708123221.11658-1-huangfq.daxian@gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  8 Jul 2019 20:32:21 +0800
Fuqian Huang <huangfq.daxian@gmail.com> wrote:

> Introduce local variable 'struct device *dev' and use it instead of
> dereferencing it repeatly.
> 
> Signed-off-by: Fuqian Huang <huangfq.daxian@gmail.com>

Ok, this is a fair bit of churn but probably on balance a worthwhile
little improvement.

Applied to the togreg branch of iio.git and pushed out
as testing to see if we missed anything.

+CC Freeman Liu as original author.

Thanks,

Jonathan


> ---
>  drivers/iio/adc/sc27xx_adc.c | 41 +++++++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index f7f7a18904b4..ec86f640e963 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -504,88 +504,89 @@ static void sc27xx_adc_free_hwlock(void *_data)
>  
>  static int sc27xx_adc_probe(struct platform_device *pdev)
>  {
> -	struct device_node *np = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
>  	struct sc27xx_adc_data *sc27xx_data;
>  	struct iio_dev *indio_dev;
>  	int ret;
>  
> -	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*sc27xx_data));
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*sc27xx_data));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	sc27xx_data = iio_priv(indio_dev);
>  
> -	sc27xx_data->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	sc27xx_data->regmap = dev_get_regmap(dev->parent, NULL);
>  	if (!sc27xx_data->regmap) {
> -		dev_err(&pdev->dev, "failed to get ADC regmap\n");
> +		dev_err(dev, "failed to get ADC regmap\n");
>  		return -ENODEV;
>  	}
>  
>  	ret = of_property_read_u32(np, "reg", &sc27xx_data->base);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to get ADC base address\n");
> +		dev_err(dev, "failed to get ADC base address\n");
>  		return ret;
>  	}
>  
>  	sc27xx_data->irq = platform_get_irq(pdev, 0);
>  	if (sc27xx_data->irq < 0) {
> -		dev_err(&pdev->dev, "failed to get ADC irq number\n");
> +		dev_err(dev, "failed to get ADC irq number\n");
>  		return sc27xx_data->irq;
>  	}
>  
>  	ret = of_hwspin_lock_get_id(np, 0);
>  	if (ret < 0) {
> -		dev_err(&pdev->dev, "failed to get hwspinlock id\n");
> +		dev_err(dev, "failed to get hwspinlock id\n");
>  		return ret;
>  	}
>  
>  	sc27xx_data->hwlock = hwspin_lock_request_specific(ret);
>  	if (!sc27xx_data->hwlock) {
> -		dev_err(&pdev->dev, "failed to request hwspinlock\n");
> +		dev_err(dev, "failed to request hwspinlock\n");
>  		return -ENXIO;
>  	}
>  
> -	ret = devm_add_action(&pdev->dev, sc27xx_adc_free_hwlock,
> +	ret = devm_add_action(dev, sc27xx_adc_free_hwlock,
>  			      sc27xx_data->hwlock);
>  	if (ret) {
>  		sc27xx_adc_free_hwlock(sc27xx_data->hwlock);
> -		dev_err(&pdev->dev, "failed to add hwspinlock action\n");
> +		dev_err(dev, "failed to add hwspinlock action\n");
>  		return ret;
>  	}
>  
>  	init_completion(&sc27xx_data->completion);
> -	sc27xx_data->dev = &pdev->dev;
> +	sc27xx_data->dev = dev;
>  
>  	ret = sc27xx_adc_enable(sc27xx_data);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to enable ADC module\n");
> +		dev_err(dev, "failed to enable ADC module\n");
>  		return ret;
>  	}
>  
> -	ret = devm_add_action(&pdev->dev, sc27xx_adc_disable, sc27xx_data);
> +	ret = devm_add_action(dev, sc27xx_adc_disable, sc27xx_data);
>  	if (ret) {
>  		sc27xx_adc_disable(sc27xx_data);
> -		dev_err(&pdev->dev, "failed to add ADC disable action\n");
> +		dev_err(dev, "failed to add ADC disable action\n");
>  		return ret;
>  	}
>  
> -	ret = devm_request_threaded_irq(&pdev->dev, sc27xx_data->irq, NULL,
> +	ret = devm_request_threaded_irq(dev, sc27xx_data->irq, NULL,
>  					sc27xx_adc_isr, IRQF_ONESHOT,
>  					pdev->name, sc27xx_data);
>  	if (ret) {
> -		dev_err(&pdev->dev, "failed to request ADC irq\n");
> +		dev_err(dev, "failed to request ADC irq\n");
>  		return ret;
>  	}
>  
> -	indio_dev->dev.parent = &pdev->dev;
> -	indio_dev->name = dev_name(&pdev->dev);
> +	indio_dev->dev.parent = dev;
> +	indio_dev->name = dev_name(dev);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &sc27xx_info;
>  	indio_dev->channels = sc27xx_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(sc27xx_channels);
> -	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	ret = devm_iio_device_register(dev, indio_dev);
>  	if (ret)
> -		dev_err(&pdev->dev, "could not register iio (ADC)");
> +		dev_err(dev, "could not register iio (ADC)");
>  
>  	return ret;
>  }

