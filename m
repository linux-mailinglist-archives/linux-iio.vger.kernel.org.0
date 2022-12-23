Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F856552BE
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 17:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiLWQWx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 11:22:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiLWQWv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 11:22:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A73E1A387;
        Fri, 23 Dec 2022 08:22:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2C577B820DF;
        Fri, 23 Dec 2022 16:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15A1C433F0;
        Fri, 23 Dec 2022 16:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671812567;
        bh=cI6gsgyw80j7PlxiMoBthl/oRYVl1bFpipihI/1mBKM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=n6k0ieXkwb/0mclWdVOXCB8uWgBxaUEr2yJo9yP3+H3HoqXjdgbm3zWQkkdJslAgy
         7+6GEsExPbCD+oeHCoPA5QxUCVO5ETQJHXg6JyWKBto+pAg/SGfqcx0kAYNz5YXW91
         4z6AmuTAifmZpjNo+4qoEKHcRbfZjZXR1H0YfKA/JwwxZfISyjTOgvY0SsBTrNNjyZ
         M8mhOI0iMK87MLVsWIOt6CI0ntP4vQqCzSfkGRoSO+568jmutg/AH0cwAbETAOKWZW
         z/g/Ac8rUe4qVZK9l0bjSrwWgo4pU0hS3OyWgyVVtqvKq5OgK6xf7z6nXYE59P8k5J
         hjIWWnuiIBI0g==
Date:   Fri, 23 Dec 2022 16:35:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     haibo.chen@nxp.com
Cc:     lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: adc: add imx93 adc support
Message-ID: <20221223163556.6db4e603@jic23-huawei>
In-Reply-To: <20221219101336.3929570-2-haibo.chen@nxp.com>
References: <20221219101336.3929570-1-haibo.chen@nxp.com>
        <20221219101336.3929570-2-haibo.chen@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Mon, 19 Dec 2022 18:13:34 +0800
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

A few minor things inline. Otherwise looks good to me.

Thanks,

Jonathan

> ---
> diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c
> new file mode 100644
> index 000000000000..3ea16a70e746
> --- /dev/null
> +++ b/drivers/iio/adc/imx93_adc.c
> @@ -0,0 +1,474 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * NXP i.MX93 ADC driver
> + *
> + * Copyright 2022 NXP
> + */
> +

...

> +/* ADC bit shift */
> +#define IMX93_ADC_MCR_MODE_MASK			BIT(29)
> +#define IMX93_ADC_MCR_NSTART_MASK		BIT(24)
> +#define IMX93_ADC_MCR_CALSTART_MASK		BIT(14)
> +#define IMX93_ADC_MCR_ADCLKSE_MASK		BIT(8)
> +#define IMX93_ADC_MCR_PWDN_MASK			BIT(0)
> +#define IMX93_ADC_MSR_CALFAIL_MASK		BIT(30)
> +#define IMX93_ADC_MSR_CALBUSY_MASK		BIT(29)
> +#define IMX93_ADC_MSR_ADCSTATUS_MASK		GENMASK(2, 0)
> +#define IMX93_ADC_ISR_ECH_MASK			BIT(0)
> +#define IMX93_ADC_ISR_EOC_MASK			BIT(1)
> +#define IMX93_ADC_ISR_EOC_ECH_MASK		(IMX93_ADC_ISR_EOC_MASK | \
> +						 IMX93_ADC_ISR_ECH_MASK)
> +#define IMX93_ADC_IMR_JEOC_MASK			BIT(3)
> +#define IMX93_ADC_IMR_JECH_MASK			BIT(2)
> +#define IMX93_ADC_IMR_EOC_MASK			BIT(1)
> +#define IMX93_ADC_IMR_ECH_MASK			BIT(0)
> +#define IMX93_ADC_PCDR_CDATA_MASK		GENMASK(11, 0)
> +
> +/* ADC status */
Are these field values? If so I'd like the naming to indicate
which field and which register etc. It might end up a bit
long, but it makes it clear the value is matched with
where we are getting it from.

> +#define IMX93_ADC_IDLE			0
> +#define IMX93_ADC_POWER_DOWN		1
> +#define IMX93_ADC_WAIT_STATE		2
> +#define IMX93_ADC_BUSY_IN_CALIBRATION	3
> +#define IMX93_ADC_SAMPLE		4
> +#define IMX93_ADC_CONVERSION		6
> +
> +#define IMX93_ADC_TIMEOUT		msecs_to_jiffies(100)


> +static int imx93_adc_read_raw(struct iio_dev *indio_dev,
> +				struct iio_chan_spec const *chan,
> +				int *val, int *val2, long mask)
> +{
> +	struct imx93_adc *adc = iio_priv(indio_dev);
> +	struct device *dev = adc->dev;
> +	long ret;
> +	u32 vref_uv;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		pm_runtime_get_sync(dev);
> +		mutex_lock(&adc->lock);
> +		ret = imx93_adc_read_channel_conversion(adc, chan->channel, val);
> +		mutex_unlock(&adc->lock);
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_sync_autosuspend(dev);
> +		if (ret > 0)
> +			return IIO_VAL_INT;
> +		else
> +			return ret;
Prefer the error out of line. Makes for slightly easier reviewing as it
is the more common pattern.

		if (ret < 0)
			return ret;

		return IIO_VAL_INT;

> +
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = vref_uv = regulator_get_voltage(adc->vref);
> +		if (ret < 0)
> +			return ret;
> +		*val = vref_uv / 1000;
> +		*val2 = 12;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = clk_get_rate(adc->ipg_clk);
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +
> +static int imx93_adc_probe(struct platform_device *pdev)
> +{

> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	init_completion(&adc->completion);
> +
> +	indio_dev->name = IMX93_ADC_DRIVER_NAME;
I'd rather see the string here than use a define. There is no strong
reason that this should be the driver name - so I don' want to have
to go look at the define to check it contains "imx93" which I'd expect
to see here.

> +
> +static int imx93_adc_remove(struct platform_device *pdev)
> +{
> +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +	struct imx93_adc *adc = iio_priv(indio_dev);
> +	struct device *dev = adc->dev;
> +
> +	/* adc power down need clock on */
> +	pm_runtime_get_sync(dev);
> +	imx93_adc_power_down(adc);
> +
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
> +	iio_device_unregister(indio_dev);

You don't remove the userspace interfaces until this iio_device_unregister()
call.  Having turned the power off before this point is probably not a good idea.
you should be fine moving the imx93_adc_power_down() after this point.
Hopefully that should reflect any equivalent handling order in probe()
(I haven't checked!)


> +	free_irq(adc->irq, adc);
> +	clk_disable_unprepare(adc->ipg_clk);
> +	regulator_disable(adc->vref);
> +
> +	return 0;
> +}
> +


