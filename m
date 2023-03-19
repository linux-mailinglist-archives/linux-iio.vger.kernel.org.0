Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A6B6C025D
	for <lists+linux-iio@lfdr.de>; Sun, 19 Mar 2023 15:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjCSOVT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 19 Mar 2023 10:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjCSOVT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2023 10:21:19 -0400
Received: from pio-pvt-msa2.bahnhof.se (pio-pvt-msa2.bahnhof.se [79.136.2.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99FB91CAD5
        for <linux-iio@vger.kernel.org>; Sun, 19 Mar 2023 07:21:16 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTP id ED3B03F46B;
        Sun, 19 Mar 2023 15:21:14 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -1.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_FAIL,SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
Received: from pio-pvt-msa2.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa2.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UZjLR9k7S3Yb; Sun, 19 Mar 2023 15:21:13 +0100 (CET)
Received: by pio-pvt-msa2.bahnhof.se (Postfix) with ESMTPA id 721743F469;
        Sun, 19 Mar 2023 15:21:12 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 8D3048EB2E;
        Sun, 19 Mar 2023 14:21:06 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Tr4Yp-yoNNvw; Sun, 19 Mar 2023 14:21:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 1491B8EB28;
        Sun, 19 Mar 2023 14:21:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YnKMg8hvJrvi; Sun, 19 Mar 2023 14:21:01 +0000 (UTC)
Received: from dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id C88948EB23;
        Sun, 19 Mar 2023 14:21:01 +0000 (UTC)
Date:   Sun, 19 Mar 2023 15:21:06 +0100
From:   Patrik =?iso-8859-1?Q?Dahlstr=F6m?= <risca@dalakolonin.se>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: palmas: Take probe fully device managed.
Message-ID: <20230319142106.GA3806863@dalakolonin.se>
References: <20230318163039.56115-1-jic23@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230318163039.56115-1-jic23@kernel.org>
Content-Transfer-Encoding: 8BIT
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The changes look good and I've tested it on Omap5-uevm board:
* module loads and unloads without issues
* I'm able to read ADC values
* the values change when I turn my potentiometer

Feel free to add the relevant tags, e.g. Tested-by or Reviewed-by. I'm
still new to the kernel development process.

On Sat, Mar 18, 2023 at 04:30:39PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Review of a recent fix highlighted that this driver could be trivially
> converted to be entirely devm managed.
> 
> That fix should be applied to resolve the fix in a fashion easy to back port
> even though this change removes the relevant code.
> 
> [1] https://patchwork.kernel.org/project/linux-iio/patch/20230313205029.1881745-1-risca@dalakolonin.se/
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Signed-off-by: Patrik Dahlström <risca@dalakolonin.se>
> ---
>  drivers/iio/adc/palmas_gpadc.c | 110 +++++++++++++--------------------
>  1 file changed, 42 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index 849a697a467e..2921186458e0 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -493,6 +493,11 @@ static int palmas_gpadc_get_adc_dt_data(struct platform_device *pdev,
>  	return 0;
>  }
>  
> +static void palmas_disable_wakeup(void *dev)
> +{
> +	device_wakeup_disable(dev);
> +}
> +
>  static int palmas_gpadc_probe(struct platform_device *pdev)
>  {
>  	struct palmas_gpadc *adc;
> @@ -532,36 +537,30 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
>  
>  	adc->auto_conversion_period = gpadc_pdata->auto_conversion_period_ms;
>  	adc->irq = palmas_irq_get_virq(adc->palmas, PALMAS_GPADC_EOC_SW_IRQ);
> -	if (adc->irq < 0) {
> -		dev_err(adc->dev,
> -			"get virq failed: %d\n", adc->irq);
> -		ret = adc->irq;
> -		goto out;
> -	}
> -	ret = request_threaded_irq(adc->irq, NULL,
> -		palmas_gpadc_irq,
> -		IRQF_ONESHOT, dev_name(adc->dev),
> -		adc);
> -	if (ret < 0) {
> -		dev_err(adc->dev,
> -			"request irq %d failed: %d\n", adc->irq, ret);
> -		goto out;
> -	}
> +	if (adc->irq < 0)
> +		return dev_err_probe(adc->dev, adc->irq, "get virq failed\n");
> +
> +	ret = devm_request_threaded_irq(&pdev->dev, adc->irq, NULL,
> +					palmas_gpadc_irq,
> +					IRQF_ONESHOT, dev_name(adc->dev),
> +					adc);
> +	if (ret < 0)
> +		return dev_err_probe(adc->dev, ret,
> +				     "request irq %d failed\n", adc->irq);
>  
>  	if (gpadc_pdata->adc_wakeup1_data) {
>  		memcpy(&adc->wakeup1_data, gpadc_pdata->adc_wakeup1_data,
>  			sizeof(adc->wakeup1_data));
>  		adc->wakeup1_enable = true;
>  		adc->irq_auto_0 =  platform_get_irq(pdev, 1);
> -		ret = request_threaded_irq(adc->irq_auto_0, NULL,
> -				palmas_gpadc_irq_auto,
> -				IRQF_ONESHOT,
> -				"palmas-adc-auto-0", adc);
> -		if (ret < 0) {
> -			dev_err(adc->dev, "request auto0 irq %d failed: %d\n",
> -				adc->irq_auto_0, ret);
> -			goto out_irq_free;
> -		}
> +		ret = devm_request_threaded_irq(&pdev->dev, adc->irq_auto_0,
> +						NULL, palmas_gpadc_irq_auto,
> +						IRQF_ONESHOT,
> +						"palmas-adc-auto-0", adc);
> +		if (ret < 0)
> +			return dev_err_probe(adc->dev, ret,
> +					     "request auto0 irq %d failed\n",
> +					     adc->irq_auto_0);
>  	}
>  
>  	if (gpadc_pdata->adc_wakeup2_data) {
> @@ -569,15 +568,14 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
>  				sizeof(adc->wakeup2_data));
>  		adc->wakeup2_enable = true;
>  		adc->irq_auto_1 =  platform_get_irq(pdev, 2);
> -		ret = request_threaded_irq(adc->irq_auto_1, NULL,
> -				palmas_gpadc_irq_auto,
> -				IRQF_ONESHOT,
> -				"palmas-adc-auto-1", adc);
> -		if (ret < 0) {
> -			dev_err(adc->dev, "request auto1 irq %d failed: %d\n",
> -				adc->irq_auto_1, ret);
> -			goto out_irq_auto0_free;
> -		}
> +		ret = devm_request_threaded_irq(&pdev->dev, adc->irq_auto_1,
> +						NULL, palmas_gpadc_irq_auto,
> +						IRQF_ONESHOT,
> +						"palmas-adc-auto-1", adc);
> +		if (ret < 0)
> +			return dev_err_probe(adc->dev, ret,
> +					     "request auto1 irq %d failed\n",
> +					     adc->irq_auto_1);
>  	}
>  
>  	/* set the current source 0 (value 0/5/15/20 uA => 0..3) */
> @@ -608,11 +606,10 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
>  	indio_dev->channels = palmas_gpadc_iio_channel;
>  	indio_dev->num_channels = ARRAY_SIZE(palmas_gpadc_iio_channel);
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0) {
> -		dev_err(adc->dev, "iio_device_register() failed: %d\n", ret);
> -		goto out_irq_auto1_free;
> -	}
> +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(adc->dev, ret,
> +				     "iio_device_register() failed\n");
>  
>  	device_set_wakeup_capable(&pdev->dev, 1);
>  	for (i = 0; i < PALMAS_ADC_CH_MAX; i++) {
> @@ -620,36 +617,14 @@ static int palmas_gpadc_probe(struct platform_device *pdev)
>  			palmas_gpadc_calibrate(adc, i);
>  	}
>  
> -	if (adc->wakeup1_enable || adc->wakeup2_enable)
> +	if (adc->wakeup1_enable || adc->wakeup2_enable) {
>  		device_wakeup_enable(&pdev->dev);
> -
> -	return 0;
> -
> -out_irq_auto1_free:
> -	if (gpadc_pdata->adc_wakeup2_data)
> -		free_irq(adc->irq_auto_1, adc);
> -out_irq_auto0_free:
> -	if (gpadc_pdata->adc_wakeup1_data)
> -		free_irq(adc->irq_auto_0, adc);
> -out_irq_free:
> -	free_irq(adc->irq, adc);
> -out:
> -	return ret;
> -}
> -
> -static int palmas_gpadc_remove(struct platform_device *pdev)
> -{
> -	struct iio_dev *indio_dev = dev_get_drvdata(&pdev->dev);
> -	struct palmas_gpadc *adc = iio_priv(indio_dev);
> -
> -	if (adc->wakeup1_enable || adc->wakeup2_enable)
> -		device_wakeup_disable(&pdev->dev);
> -	iio_device_unregister(indio_dev);
> -	free_irq(adc->irq, adc);
> -	if (adc->wakeup1_enable)
> -		free_irq(adc->irq_auto_0, adc);
> -	if (adc->wakeup2_enable)
> -		free_irq(adc->irq_auto_1, adc);
> +		ret = devm_add_action_or_reset(&pdev->dev,
> +					       palmas_disable_wakeup,
> +					       &pdev->dev);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	return 0;
>  }
> @@ -834,7 +809,6 @@ MODULE_DEVICE_TABLE(of, of_palmas_gpadc_match_tbl);
>  
>  static struct platform_driver palmas_gpadc_driver = {
>  	.probe = palmas_gpadc_probe,
> -	.remove = palmas_gpadc_remove,
>  	.driver = {
>  		.name = MOD_NAME,
>  		.pm = pm_sleep_ptr(&palmas_pm_ops),
> -- 
> 2.40.0
> 
