Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 615C9400F7D
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 14:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237907AbhIEMJN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 08:09:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234382AbhIEMJM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 08:09:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3936160E97;
        Sun,  5 Sep 2021 12:08:02 +0000 (UTC)
Date:   Sun, 5 Sep 2021 13:11:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, bcousson@baylibre.com,
        Tony Lindgren <tony@atomide.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>
Subject: Re: [PATCH v2 19/46] mfd: ti_am335x_tscadc: Drop useless variables
 from the driver structure
Message-ID: <20210905131125.7f55173e@jic23-huawei>
In-Reply-To: <20210902215144.507243-20-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
        <20210902215144.507243-20-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Sep 2021 23:51:17 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Keeping the count of tsc_cells and adc_cells is completely redundant, we
> can derive this information from other variables. Plus, these variables
> are not used anywhere else now. Let's get rid of them.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Makes sense and nice to get rid of these.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/mfd/ti_am335x_tscadc.c       | 15 ++++-----------
>  include/linux/mfd/ti_am335x_tscadc.h |  3 ---
>  2 files changed, 4 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 0dcc2151ac1f..4a24fc1141cf 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -122,7 +122,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	const __be32 *cur;
>  	u32 val;
>  	int err, ctrl;
> -	int tsc_wires = 0, adc_channels = 0, total_channels;
> +	int tsc_wires = 0, adc_channels = 0, cell_idx = 0, total_channels;
>  	int readouts = 0;
>  
>  	/* Allocate memory for device */
> @@ -237,14 +237,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	ctrl |= CNTRLREG_TSCSSENB;
>  	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
>  
> -	tscadc->used_cells = 0;
> -	tscadc->tsc_cell = -1;
> -	tscadc->adc_cell = -1;
> -
>  	/* TSC Cell */
>  	if (tsc_wires > 0) {
> -		tscadc->tsc_cell = tscadc->used_cells;
> -		cell = &tscadc->cells[tscadc->used_cells++];
> +		cell = &tscadc->cells[cell_idx++];
>  		cell->name = tscadc->data->name_tscmag;
>  		cell->of_compatible = tscadc->data->compat_tscmag;
>  		cell->platform_data = &tscadc;
> @@ -253,8 +248,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  
>  	/* ADC Cell */
>  	if (adc_channels > 0) {
> -		tscadc->adc_cell = tscadc->used_cells;
> -		cell = &tscadc->cells[tscadc->used_cells++];
> +		cell = &tscadc->cells[cell_idx++];
>  		cell->name = tscadc->data->name_adc;
>  		cell->of_compatible = tscadc->data->compat_adc;
>  		cell->platform_data = &tscadc;
> @@ -262,8 +256,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	}
>  
>  	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_AUTO,
> -			      tscadc->cells, tscadc->used_cells, NULL,
> -			      0, NULL);
> +			      tscadc->cells, cell_idx, NULL, 0, NULL);
>  	if (err < 0)
>  		goto err_disable_clk;
>  
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index 0f581c15d95a..e734fb97dff8 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -177,10 +177,7 @@ struct ti_tscadc_dev {
>  	phys_addr_t tscadc_phys_base;
>  	const struct ti_tscadc_data *data;
>  	int irq;
> -	int used_cells;	/* 1-2 */
>  	int tsc_wires;
> -	int tsc_cell;	/* -1 if not used */
> -	int adc_cell;	/* -1 if not used */
>  	struct mfd_cell cells[TSCADC_CELLS];
>  	u32 reg_se_cache;
>  	bool adc_waiting;

