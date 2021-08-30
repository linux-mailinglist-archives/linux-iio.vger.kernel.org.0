Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5033FB869
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 16:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbhH3OoU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 10:44:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:45020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233798AbhH3OoT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 10:44:19 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 178B460E77;
        Mon, 30 Aug 2021 14:43:19 +0000 (UTC)
Date:   Mon, 30 Aug 2021 15:46:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>,
        Tero Kristo <t-kristo@ti.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        "Ryan J . Barnett" <ryan.barnett@collins.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-clk@vger.kernel.org, Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH 16/40] mfd: ti_am335x_tscadc: Use driver data
Message-ID: <20210830154631.01497b69@jic23-huawei>
In-Reply-To: <20210825152518.379386-17-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-17-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:24:54 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> So far every sub-cell parameter in this driver was hardcoded: cell name,
> cell compatible, specific clock name and desired clock frequency.
> 
> As we are about to introduce support for ADC1/magnetic reader, we need a
> bit of flexibility. Let's add a driver data structure which will contain
> these information.
> 
> Co-developed-by: Jason Reeder <jreeder@ti.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Jason Reeder <jreeder@ti.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c       | 20 +++++++++++++++-----
>  include/linux/mfd/ti_am335x_tscadc.h |  9 +++++++++
>  2 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 3231ccbbad02..0cea44b4bd1a 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -136,6 +136,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +	tscadc->data = of_device_get_match_data(&pdev->dev);

As mentioned in later patch, I can't see that you actually wired this up here.
match_data doesn't seem to be set.

Otherwise looks fine to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>



> +
>  	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
>  	of_property_read_u32(node, "ti,wires", &tsc_wires);
>  	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
> @@ -209,7 +211,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  		goto err_disable_clk;
>  	}
>  
> -	tscadc->clk_div = (clk_get_rate(clk) / ADC_CLK) - 1;
> +	tscadc->clk_div = (clk_get_rate(clk) / tscadc->data->target_clk_rate) - 1;
>  	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
>  
>  	/* Set the control register bits */
> @@ -238,8 +240,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	if (tsc_wires > 0) {
>  		tscadc->tsc_cell = tscadc->used_cells;
>  		cell = &tscadc->cells[tscadc->used_cells++];
> -		cell->name = "TI-am335x-tsc";
> -		cell->of_compatible = "ti,am3359-tsc";
> +		cell->name = tscadc->data->name_tscmag;
> +		cell->of_compatible = tscadc->data->compat_tscmag;
>  		cell->platform_data = &tscadc;
>  		cell->pdata_size = sizeof(tscadc);
>  	}
> @@ -248,8 +250,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	if (adc_channels > 0) {
>  		tscadc->adc_cell = tscadc->used_cells;
>  		cell = &tscadc->cells[tscadc->used_cells++];
> -		cell->name = "TI-am335x-adc";
> -		cell->of_compatible = "ti,am3359-adc";
> +		cell->name = tscadc->data->name_adc;
> +		cell->of_compatible = tscadc->data->compat_adc;
>  		cell->platform_data = &tscadc;
>  		cell->pdata_size = sizeof(tscadc);
>  	}
> @@ -335,6 +337,14 @@ static int __maybe_unused tscadc_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(tscadc_pm_ops, tscadc_suspend, tscadc_resume);
>  
> +static const struct ti_tscadc_data tscdata = {
> +	.name_tscmag = "TI-am335x-tsc",
> +	.compat_tscmag = "ti,am3359-tsc",
> +	.name_adc = "TI-am335x-adc",
> +	.compat_adc = "ti,am3359-adc",
> +	.target_clk_rate = ADC_CLK,
> +};
> +
>  static const struct of_device_id ti_tscadc_dt_ids[] = {
>  	{ .compatible = "ti,am3359-tscadc", },
>  	{ }
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index ffc091b77633..0f581c15d95a 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -162,11 +162,20 @@
>  
>  #define TSCADC_CELLS		2
>  
> +struct ti_tscadc_data {
> +	char *name_tscmag;
> +	char *compat_tscmag;
> +	char *name_adc;
> +	char *compat_adc;
> +	unsigned int target_clk_rate;
> +};
> +
>  struct ti_tscadc_dev {
>  	struct device *dev;
>  	struct regmap *regmap;
>  	void __iomem *tscadc_base;
>  	phys_addr_t tscadc_phys_base;
> +	const struct ti_tscadc_data *data;
>  	int irq;
>  	int used_cells;	/* 1-2 */
>  	int tsc_wires;

