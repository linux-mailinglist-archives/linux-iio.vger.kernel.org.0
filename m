Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4011B4079D3
	for <lists+linux-iio@lfdr.de>; Sat, 11 Sep 2021 19:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhIKR0h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Sep 2021 13:26:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:49098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230018AbhIKR0h (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Sep 2021 13:26:37 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6C51060F56;
        Sat, 11 Sep 2021 17:25:21 +0000 (UTC)
Date:   Sat, 11 Sep 2021 18:28:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] iio: imx8qxp-adc: Add driver support for NXP
 IMX8QXP ADC
Message-ID: <20210911182852.5693ad7d@jic23-huawei>
In-Reply-To: <20210907015724.1377-2-caihuoqing@baidu.com>
References: <20210907015724.1377-1-caihuoqing@baidu.com>
        <20210907015724.1377-2-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 7 Sep 2021 09:57:21 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> The NXP i.MX 8QuadXPlus SOC has a new ADC IP. These patches add
> driver support for this ADC.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Hi,

A few minor things inline.  This is looking pretty good to me!

Jonathan

> ---
> v1->v2:	*Squash patches 1, 2, 3, and 5 into a single patch.
> 	*Add device specific prefix.
> 	*Remove the brackets around individual numbers.
> 	*Make use of FIELD_PREP() and FIELD_GET().
> 	*Remove a lot of cache values.
> 	*Replace mlock with adc->lock.
> 	*Move adc->value read from isr to the completion.
> 	*Set pm_runtime_disable/_put_noidle() before adc_disable.
> 	*Add error handler-err_disable_reg/err_unprepare_clk.
> v2->v3:	*Add "return 0" to adc_runtime_resume().
> v1 link:
> https://patchwork.kernel.org/project/linux-arm-kernel/patch/20210830172140.414-4-caihuoqing@baidu.com/
> 
>  drivers/iio/adc/Kconfig       |  10 +
>  drivers/iio/adc/Makefile      |   1 +
>  drivers/iio/adc/imx8qxp-adc.c | 470 ++++++++++++++++++++++++++++++++++
>  3 files changed, 481 insertions(+)
>  create mode 100644 drivers/iio/adc/imx8qxp-adc.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index af168e1c9fdb..fa8ad63d6ac2 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -530,6 +530,16 @@ config IMX7D_ADC
....
> diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
> new file mode 100644
> index 000000000000..9ba77af360f3
> --- /dev/null
> +++ b/drivers/iio/adc/imx8qxp-adc.c
> @@ -0,0 +1,470 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * NXP i.MX8QXP ADC driver
> + *
> + * Based on the work of Haibo Chen <haibo.chen@nxp.com>
> + * The initial developer of the original code is Haibo Chen.
> + * Portions created by Haibo Chen are Copyright (C) 2018 NXP.
> + * All Rights Reserved.
> + *
> + * Copyright (C) 2018 NXP
> + * Copyright (C) 2021 Cai Huoqing
> + */
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>

Not in alphabetical order.

> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>

...

> +static irqreturn_t imx8qxp_adc_isr(int irq, void *dev_id)
> +{
> +	struct imx8qxp_adc *adc = (struct imx8qxp_adc *)dev_id;

Never any need to explicitly cast from void * in c.

	struct imx8qpx_adc *adc = dev_id;

> +
> +	u32 fifo_count;
> +
> +	fifo_count = FIELD_GET(IMX8QXP_ADC_FCTRL_FCOUNT_MASK,
> +			       readl(adc->regs + IMX8QXP_ADR_ADC_FCTRL));
> +
> +	if (fifo_count)
> +		complete(&adc->completion);
> +
> +	return IRQ_HANDLED;
> +}
> +

...

> +
> +static int imx8qxp_adc_probe(struct platform_device *pdev)
> +{
> +	struct imx8qxp_adc *adc;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &pdev->dev;
> +	int irq;
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
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	adc->clk = devm_clk_get(dev, "per");
> +	if (IS_ERR(adc->clk)) {
> +		ret = PTR_ERR(adc->clk);
> +		dev_err(dev, "Failed getting clock, err = %d\n", ret);
> +		return ret;
> +	}
> +
> +	adc->ipg_clk = devm_clk_get(dev, "ipg");
> +	if (IS_ERR(adc->ipg_clk)) {
> +		ret = PTR_ERR(adc->ipg_clk);
> +		dev_err(dev, "Failed getting clock, err = %d\n", ret);
> +		return ret;
> +	}
> +
> +	adc->vref = devm_regulator_get(dev, "vref");
> +	if (IS_ERR(adc->vref)) {
> +		ret = PTR_ERR(adc->vref);
> +		dev_err(dev,
		return dev_err_probe(dev, PTR_ERR(adc->vref), "Failed getting reference voltage\n");

as might be a deferred case and then we don't want errors filling up the log.
This function also deals with reporting error codes etc for you.
Same for anything else that might be deferred because of driver load ordering
(clks for example)


> +			"Failed getting reference voltage, err = %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	init_completion(&adc->completion);
> +
> +	indio_dev->name = dev_name(dev);
> +	indio_dev->info = &imx8qxp_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = imx8qxp_adc_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(imx8qxp_adc_iio_channels);
> +
> +	ret = devm_request_irq(dev, irq, imx8qxp_adc_isr, 0, dev_name(dev), adc);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed requesting irq, irq = %d\n", irq);
> +		return ret;
> +	}
> +
> +	imx8qxp_adc_reset(adc);
> +
> +	ret = iio_device_register(indio_dev);
> +	if (ret) {
> +		imx8qxp_adc_disable(adc);
> +		dev_err(dev, "Couldn't register the device.\n");
> +		return ret;
> +	}
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 50);
> +	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_enable(dev);
> +
> +	return 0;
> +}
> +

...

> +static int imx8qxp_adc_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct imx8qxp_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regulator_enable(adc->vref);
> +	if (ret) {
> +		dev_err(dev, "Can't enable adc reference top voltage, err = %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(adc->clk);
> +	if (ret) {
> +		dev_err(dev, "Could not prepare or enable clock.\n");
> +		goto err_disable_reg;
> +	}
> +
> +	ret = clk_prepare_enable(adc->ipg_clk);
> +	if (ret) {
> +		dev_err(dev, "Could not prepare or enable clock.\n");
> +		goto err_unprepare_clk;
> +	}

Blank lines here (to separate statement + error handler from next statement)

> +	imx8qxp_adc_reset(adc);

here

> +	return 0;

and here would help readability (slightly!)

> +err_unprepare_clk:
> +	clk_disable_unprepare(adc->clk);
> +
> +err_disable_reg:
> +	regulator_disable(adc->vref);
> +
> +	return ret;
> +}
> +
...
