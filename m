Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106AC659B8E
	for <lists+linux-iio@lfdr.de>; Fri, 30 Dec 2022 20:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiL3TDO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 30 Dec 2022 14:03:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3TDN (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 30 Dec 2022 14:03:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFAB1B9E3;
        Fri, 30 Dec 2022 11:03:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3694361B76;
        Fri, 30 Dec 2022 19:03:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46F8C433D2;
        Fri, 30 Dec 2022 19:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672426991;
        bh=CoyJlW49fOqwJ+4r20pKWD1OZFtwRKrkSTZjaCFJLq8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bq+J983/JdlT5ZqidG79JKn5LV8hl1VMzzLihJXwmKaMUH7FD3dVEQqf70/ItOwGK
         xoWydqHW5I+ILgkFGBL4b58aACdBnW7XjCmujNJ3pd9t3VqfGzyx78xglkLMrdxJs9
         getOCAc/zXCzDYe6SmebGy5qacoRiw+XvbNHFrlAF0Dr7WNxlYPGC0IKbxx2QOLz2n
         5DI+ZBWE/zYGzW6OMUrzZSbDptSsdS3sSIdkTWgsC/K68vL/QyxHANoy/MzSccCzAf
         EqUKL+NQDFAOdrCKo444wZUCq8B89+qKkLCF+AqIjjpBV+gfuQNCJbmxx2mCJvHED3
         9q9sfWv77wMUA==
Date:   Fri, 30 Dec 2022 19:16:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     haibo.chen@nxp.com
Cc:     lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/3] iio: adc: add imx93 adc support
Message-ID: <20221230191629.01205144@jic23-huawei>
In-Reply-To: <20221226042719.694659-2-haibo.chen@nxp.com>
References: <20221226042719.694659-1-haibo.chen@nxp.com>
        <20221226042719.694659-2-haibo.chen@nxp.com>
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

On Mon, 26 Dec 2022 12:27:17 +0800
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

I think there are still improvements to be made in ordering in probe()/remove()
and also you aren't calling pm_runtime_dont_use_autosuspend()
which is a requirement if manually handling runtime pm disabling on remove()

Jonathan

> ---
>
> diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
> new file mode 100644
> index 000000000000..677f13a040f8
> --- /dev/null
> +++ b/drivers/iio/adc/imx93_adc.c
> @@ -0,0 +1,477 @@



> +static int imx93_adc_probe(struct platform_device *pdev)
> +{
> +	struct imx93_adc *adc;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev) {
> +		dev_err(dev, "Failed allocating iio device\n");
> +		return -ENOMEM;
> +	}
> +
> +	adc = iio_priv(indio_dev);
> +	adc->dev = dev;
> +
> +	mutex_init(&adc->lock);
> +	adc->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(adc->regs))
> +		return PTR_ERR(adc->regs);
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
> +	if (ret) {
> +		dev_err(dev, "Can't enable adc reference top voltage.\n");

You can use dev_err_probe() for all such handling in probe() whether or not
it can defer.  That tends to simplify things and avoids the need for reviewers
to consider if a function can defer of not.

> +		return ret;
> +	}
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
> +		dev_err(&pdev->dev, "Could not prepare or enable the clock.\n");
> +		goto error_regulator_disable;
> +	}
> +
> +	ret = request_irq(adc->irq, imx93_adc_isr, 0, IMX93_ADC_DRIVER_NAME, adc);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed requesting irq, irq = %d\n", adc->irq);
> +		goto error_ipg_clk_disable;
> +	}
> +
> +	ret = imx93_adc_calibration(adc);
> +	if (ret < 0)
> +		goto error_free_adc_irq;
> +
> +	imx93_adc_config_ad_clk(adc);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		dev_err(dev, "Couldn't register the device.\n");
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
> +
> +	/* adc power down need clock on */
> +	pm_runtime_get_sync(dev);
> +
> +	iio_device_unregister(indio_dev);
> +	imx93_adc_power_down(adc);

Why is there no similar power down in the error path in probe for
iio_device_register() returning an error?

> +	free_irq(adc->irq, adc);
> +	clk_disable_unprepare(adc->ipg_clk);
> +	regulator_disable(adc->vref);
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);

I think I caused confusion a bit here by pointing out the device unregister
needed to be first. That's now fine, but the rest would benefit from a rethink.
To my mind, the ideal situation is that the remove() is a reverse of the probe()
function, so I'd expect to see these pm_runtime_disable(), pm_runtime_put_noidle()
at the start of this
function.  Note that you also need to call pm_runtime_dont_use_autosuspend() somewhere
in here - or take all the probe/remove devm_ managed and use
devm_pm_runtime_enable() which tidies that up for you as needed.
(see docs in pm_runtime.h)

> +
> +	return 0;
> +}

