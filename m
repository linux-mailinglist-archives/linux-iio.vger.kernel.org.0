Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FBC9661559
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 14:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjAHNIO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Jan 2023 08:08:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjAHNIN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2023 08:08:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51538E0B8;
        Sun,  8 Jan 2023 05:08:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BD9FB80064;
        Sun,  8 Jan 2023 13:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC599C433D2;
        Sun,  8 Jan 2023 13:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673183289;
        bh=DJq8QxcSOWrcMi28Y4XbKU2EzQc7bbSIjXDuNYvJUPQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jZv/RLcnR5wnf5batn5N3jdPKg6f3DljFQaGf6Y+0d+BTm+e2vpP+MDxZcgnhZJ06
         kwqQbqTlPgNV0iaunrcafLqry+o33RQWRIGAs4NyIlsZQr6CgEhVjOZA7pAJrfRR21
         JreXi4a6XVSr1kDC3wb8VGp1OgHqqXxHQP3jVJXaJ9LUQajJ99TSOMP/j+C7/123k2
         wWcrP0bE+pSN4JYY04nOxPzyMa+KiSjt3PbVd14gEzYWdhAoRCwX2hi5x0g8E14b3f
         2NvIgzhxjdxBnfKr136S0GHeWY7Ngn68huP6p7SpnEY/I/zihkIkqazTERk1T4f0kb
         IZkYshhS4v78A==
Date:   Sun, 8 Jan 2023 13:21:37 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     haibo.chen@nxp.com
Cc:     lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/3] iio: adc: add imx93 adc support
Message-ID: <20230108132137.1f965aa3@jic23-huawei>
In-Reply-To: <20230103114359.2663262-2-haibo.chen@nxp.com>
References: <20230103114359.2663262-1-haibo.chen@nxp.com>
        <20230103114359.2663262-2-haibo.chen@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  3 Jan 2023 19:43:56 +0800
haibo.chen@nxp.com wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
> 
> The ADC in i.mx93 is a total new ADC IP, add a driver to support
> this ADC.
> 
> Currently, only support one shot normal conversion triggered by
> software. For other mode, will add in future.
> 
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Hi Haibo,

I'm still not sure about the power handling in remove. One other
minor comment inline that would be good to clean up for v6.

Thanks,

Jonathan

> new file mode 100644
> index 000000000000..0c98de438919
> --- /dev/null
> +++ b/drivers/iio/adc/imx93_adc.c

...

> +
> +static int imx93_adc_calibration(struct imx93_adc *adc)
> +{
> +	u32 mcr, msr;
> +	int ret;
> +
> +	/* make sure ADC in power down mode */
> +	imx93_adc_power_down(adc);
> +
> +	/* config SAR controller operating clock */
> +	mcr = readl(adc->regs + IMX93_ADC_MCR);
> +	mcr &= ~FIELD_PREP(IMX93_ADC_MCR_ADCLKSE_MASK, 1);
> +	writel(mcr, adc->regs + IMX93_ADC_MCR);
> +
> +	imx93_adc_power_up(adc);

I think this function should be side effect free on error to aid easy reviewing
/ code modularity. Thus if anything after this point fails, the device
should be deliberately powered down again to remove that side effect.

> +
> +	/*
> +	 * TODO: we use the default TSAMP/NRSMPL/AVGEN in MCR,
> +	 * can add the setting of these bit if need in future.
> +	 */
> +
> +	/* run calibration */
> +	mcr = readl(adc->regs + IMX93_ADC_MCR);
> +	mcr |= FIELD_PREP(IMX93_ADC_MCR_CALSTART_MASK, 1);
> +	writel(mcr, adc->regs + IMX93_ADC_MCR);
> +
> +	/* wait calibration to be finished */
> +	ret = readl_poll_timeout(adc->regs + IMX93_ADC_MSR, msr,
> +		!(msr & IMX93_ADC_MSR_CALBUSY_MASK), 1000, 2000000);
> +	if (ret == -ETIMEDOUT) {
> +		dev_warn(adc->dev, "ADC do not finish calibration in 1 min!\n");
> +		return ret;
> +	}
> +
> +	/* check whether calbration is success or not */
> +	msr = readl(adc->regs + IMX93_ADC_MSR);
> +	if (msr & IMX93_ADC_MSR_CALFAIL_MASK) {
> +		dev_warn(adc->dev, "ADC calibration failed!\n");
> +		return -EAGAIN;
> +	}
> +
> +	return 0;
> +}
> +

...

> +static int imx93_adc_probe(struct platform_device *pdev)
> +{
> +	struct imx93_adc *adc;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "Failed allocating iio device\n");
> +
> +	adc = iio_priv(indio_dev);
> +	adc->dev = dev;
> +
> +	mutex_init(&adc->lock);
> +	adc->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(adc->regs))
> +		return dev_err_probe(dev, PTR_ERR(adc->regs),
> +				     "Failed geting ioremap resource\n");
> +
> +	/* The third irq is for ADC conversion usage */
> +	adc->irq = platform_get_irq(pdev, 2);
> +	if (adc->irq < 0)
> +		return adc->irq;
> +
> +	adc->ipg_clk = devm_clk_get(dev, "ipg");
> +	if (IS_ERR(adc->ipg_clk))
> +		return dev_err_probe(dev, PTR_ERR(adc->ipg_clk),
> +				     "Failed getting clock.\n");
> +
> +	adc->vref = devm_regulator_get(dev, "vref");
> +	if (IS_ERR(adc->vref))
> +		return dev_err_probe(dev, PTR_ERR(adc->vref),
> +				     "Failed getting reference voltage.\n");
> +
> +	ret = regulator_enable(adc->vref);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable reference voltage.\n");
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	init_completion(&adc->completion);
> +
> +	indio_dev->name = "imx93-adc";
> +	indio_dev->info = &imx93_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = imx93_adc_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(imx93_adc_iio_channels);
> +
> +	ret = clk_prepare_enable(adc->ipg_clk);
> +	if (ret) {
> +		dev_err_probe(dev, ret,
> +			      "Failed to enable ipg clock.\n");
> +		goto error_regulator_disable;
> +	}
> +
> +	ret = request_irq(adc->irq, imx93_adc_isr, 0, IMX93_ADC_DRIVER_NAME, adc);
> +	if (ret < 0) {
> +		dev_err_probe(dev, ret,
> +			      "Failed requesting irq, irq = %d\n", adc->irq);
> +		goto error_ipg_clk_disable;
> +	}
> +
> +	ret = imx93_adc_calibration(adc);
> +	if (ret < 0)

As above, I'd expect the device to be powered down if this function fails
and hence need an additional error label.

> +		goto error_free_adc_irq;
> +
> +	imx93_adc_config_ad_clk(adc);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err_probe(dev, ret,
> +			      "Failed to register this iio device.\n");
> +		goto error_free_adc_irq;
> +	}
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 50);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +
> +error_free_adc_irq:
> +	imx93_adc_power_down(adc);
> +	free_irq(adc->irq, adc);
> +error_ipg_clk_disable:
> +	clk_disable_unprepare(adc->ipg_clk);
> +error_regulator_disable:
> +	regulator_disable(adc->vref);
> +
> +	return ret;
> +}
> +
> +static int imx93_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct imx93_adc *adc = iio_priv(indio_dev);
> +	struct device *dev = adc->dev;

As per reply to cover letter I don't understand logic by which we
are definitely runtime resumed at this stage.

> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_dont_use_autosuspend(dev);
> +	pm_runtime_put_noidle(dev);

This is not balanced with a pm_runtime_get* so I think we underflow
(which is protected against in runtime pm ref counting but not a nice
thing to do deliberately).

> +	iio_device_unregister(indio_dev);
> +	imx93_adc_power_down(adc);
> +	free_irq(adc->irq, adc);
> +	clk_disable_unprepare(adc->ipg_clk);
> +	regulator_disable(adc->vref);
> +
> +	return 0;
> +}
> +

