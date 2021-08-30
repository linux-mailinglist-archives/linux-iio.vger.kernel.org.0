Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9A03FB88B
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 16:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237245AbhH3Ovg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 10:51:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:47580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234246AbhH3Ovg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 10:51:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C2366056B;
        Mon, 30 Aug 2021 14:50:36 +0000 (UTC)
Date:   Mon, 30 Aug 2021 15:53:48 +0100
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
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 23/40] mfd: ti_am335x_tscadc: Rename a variable
Message-ID: <20210830155348.528555ea@jic23-huawei>
In-Reply-To: <20210825152518.379386-24-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-24-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:25:01 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> We need to retrieve the number of wires used by the "secondary" device
> (the touchscreen or the magnetic reader). Let's rename tsc_wires to
> become tscmag_wires to clarify the fact that this variable can be used
> in both situations.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Seems sensible.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/mfd/ti_am335x_tscadc.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 02477ce827d0..047426a74a2e 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -121,7 +121,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	const __be32 *cur;
>  	struct clk *clk;
>  	u32 val;
> -	int tsc_wires = 0, adc_channels = 0, readouts = 0, cell_idx = 0;
> +	int tscmag_wires = 0, adc_channels = 0, readouts = 0, cell_idx = 0;
>  	int total_channels, err;
>  
>  	/* Allocate memory for device */
> @@ -139,7 +139,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	tscadc->data = of_device_get_match_data(&pdev->dev);
>  
>  	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
> -	of_property_read_u32(node, "ti,wires", &tsc_wires);
> +	of_property_read_u32(node, "ti,wires", &tscmag_wires);
>  	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
>  
>  	node = of_get_child_by_name(pdev->dev.of_node, "adc");
> @@ -152,7 +152,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> -	total_channels = tsc_wires + adc_channels;
> +	total_channels = tscmag_wires + adc_channels;
>  	if (total_channels > 8) {
>  		dev_err(&pdev->dev, "Number of i/p channels more than 8\n");
>  		return -EINVAL;
> @@ -218,9 +218,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	tscadc->ctrl = CNTRLREG_TSC_STEPCONFIGWRT | CNTRLREG_STEPID;
>  	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
>  
> -	if (tsc_wires > 0) {
> +	if (tscmag_wires > 0) {
>  		tscadc->ctrl |= CNTRLREG_TSC_ENB;
> -		if (tsc_wires == 5)
> +		if (tscmag_wires == 5)
>  			tscadc->ctrl |= CNTRLREG_TSC_5WIRE;
>  		else
>  			tscadc->ctrl |= CNTRLREG_TSC_4WIRE;
> @@ -232,7 +232,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_SSENB);
>  
>  	/* TSC Cell */
> -	if (tsc_wires > 0) {
> +	if (tscmag_wires > 0) {
>  		cell = &tscadc->cells[cell_idx++];
>  		cell->name = tscadc->data->name_tscmag;
>  		cell->of_compatible = tscadc->data->compat_tscmag;

