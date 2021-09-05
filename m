Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 686C3400F4F
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 13:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbhIEL16 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 07:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhIEL15 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 07:27:57 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F95B60F56;
        Sun,  5 Sep 2021 11:26:50 +0000 (UTC)
Date:   Sun, 5 Sep 2021 12:30:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     <lars@metafoo.de>, <robh+dt@kernel.org>, <shawnguo@kernel.org>,
        <s.hauer@pengutronix.de>, <kernel@pengutronix.de>,
        <festevam@gmail.com>, <linux-imx@nxp.com>,
        <alex.dewar90@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] iio: adc: Init the driver for NXP i.MX8QuadXPlus
Message-ID: <20210905123012.17b11c21@jic23-huawei>
In-Reply-To: <20210830172140.414-2-caihuoqing@baidu.com>
References: <20210830172140.414-1-caihuoqing@baidu.com>
        <20210830172140.414-2-caihuoqing@baidu.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 31 Aug 2021 01:21:35 +0800
Cai Huoqing <caihuoqing@baidu.com> wrote:

> ADC
> 
> The NXP i.MX 8QuadXPlus SOC has a new ADC IP. This patch init
> this ADC driver.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
> ---
>  drivers/iio/adc/imx8qxp-adc.c | 67 +++++++++++++++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 drivers/iio/adc/imx8qxp-adc.c
> 
> diff --git a/drivers/iio/adc/imx8qxp-adc.c b/drivers/iio/adc/imx8qxp-adc.c
> new file mode 100644
> index 000000000000..aec1b45c8fb9
> --- /dev/null
> +++ b/drivers/iio/adc/imx8qxp-adc.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * NXP i.MX8QXP ADC driver
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/platform_device.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/driver.h>
> +#include <linux/iio/sysfs.h>
A good example of why you shouldn't have had so many small patches is
that reviewers want to look at a patch on it's own. In this case
we can't tell if you are going to use these headers later or not.
Hence review is more complex.

I'll have a brief go at reviewing, but reality is a real review needs
to be easier to do than it is here!

I will note though that alphabetical order, perhaps with iio includes
in their own block is preferred for headers in IIO drivers.


> +
> +#define ADC_DRIVER_NAME		"imx8qxp-adc"
> +
> +static int imx8qxp_adc_probe(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static int imx8qxp_adc_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}
> +
> +static int imx8qxp_adc_runtime_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int imx8qxp_adc_runtime_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops imx8qxp_adc_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(imx8qxp_adc_runtime_suspend, imx8qxp_adc_runtime_resume, NULL)
> +};
> +
> +static const struct of_device_id imx8qxp_adc_match[] = {
> +	{ .compatible = "nxp,imx8qxp-adc", },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, imx8qxp_adc_match);
> +
> +static struct platform_driver imx8qxp_adc_driver = {
> +	.probe		= imx8qxp_adc_probe,
> +	.remove		= imx8qxp_adc_remove,
> +	.driver		= {
> +		.name	= ADC_DRIVER_NAME,
> +		.of_match_table = imx8qxp_adc_match,
> +		.pm	= &imx8qxp_adc_pm_ops,
> +	},
> +};
> +
> +module_platform_driver(imx8qxp_adc_driver);
> +
> +MODULE_DESCRIPTION("i.MX8QuadXPlus ADC driver");
> +MODULE_LICENSE("GPL v2");

