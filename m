Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA40C400F93
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 14:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237939AbhIEMSK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 08:18:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:45708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234382AbhIEMSK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 08:18:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 166B660F12;
        Sun,  5 Sep 2021 12:17:00 +0000 (UTC)
Date:   Sun, 5 Sep 2021 13:20:22 +0100
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
Subject: Re: [PATCH v2 22/46] mfd: ti_am335x_tscadc: Gather the ctrl
 register logic in one place
Message-ID: <20210905132022.18a63b2d@jic23-huawei>
In-Reply-To: <20210902215144.507243-23-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
        <20210902215144.507243-23-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Sep 2021 23:51:20 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Instead of deriving in the probe and in the resume path the value of the
> ctrl register, let's do it only once in the probe, save the value of
> this register in the driver's structure and use it from the resume
> callback.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/mfd/ti_am335x_tscadc.c       | 33 ++++++++--------------------
>  include/linux/mfd/ti_am335x_tscadc.h |  2 +-
>  2 files changed, 10 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 61f878c7593b..a3ff3cc29318 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -121,7 +121,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	struct property *prop;
>  	const __be32 *cur;
>  	u32 val;
> -	int err, ctrl;
> +	int err;
>  	int tsc_wires = 0, adc_channels = 0, cell_idx = 0, total_channels;
>  	int readouts = 0;
>  
> @@ -220,21 +220,20 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
>  
>  	/* Set the control register bits */
> -	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
> +	tscadc->ctrl = CNTRLREG_STEPCONFIGWRT | CNTRLREG_STEPID;
>  	if (tsc_wires > 0) {
> -		tscadc->tsc_wires = tsc_wires;
> +		tscadc->ctrl |= CNTRLREG_TSCENB;
>  		if (tsc_wires == 5)
> -			ctrl |= CNTRLREG_5WIRE | CNTRLREG_TSCENB;
> +			tscadc->ctrl |= CNTRLREG_5WIRE;
>  		else
> -			ctrl |= CNTRLREG_4WIRE | CNTRLREG_TSCENB;
> +			tscadc->ctrl |= CNTRLREG_4WIRE;
>  	}
> -	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
> +	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
>  
>  	tscadc_idle_config(tscadc);
>  
>  	/* Enable the TSC module enable bit */
> -	ctrl |= CNTRLREG_TSCSSENB;
> -	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
> +	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_TSCSSENB);
>  
>  	/* TSC Cell */
>  	if (tsc_wires > 0) {
> @@ -309,27 +308,13 @@ static int __maybe_unused tscadc_suspend(struct device *dev)
>  static int __maybe_unused tscadc_resume(struct device *dev)
>  {
>  	struct ti_tscadc_dev *tscadc = dev_get_drvdata(dev);
> -	u32 ctrl;
>  
>  	pm_runtime_get_sync(dev);
>  
> -	/* context restore */
>  	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
> -
> -	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
> -	if (tscadc->tsc_wires > 0) {
> -		if (tscadc->tsc_wires == 5)
> -			ctrl |= CNTRLREG_5WIRE | CNTRLREG_TSCENB;
> -		else
> -			ctrl |= CNTRLREG_4WIRE | CNTRLREG_TSCENB;
> -	}
> -
> -	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
> -
> +	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
>  	tscadc_idle_config(tscadc);
> -
> -	ctrl |= CNTRLREG_TSCSSENB;
> -	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
> +	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_TSCSSENB);
>  
>  	return 0;
>  }
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index e734fb97dff8..02963b6ebbac 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -177,8 +177,8 @@ struct ti_tscadc_dev {
>  	phys_addr_t tscadc_phys_base;
>  	const struct ti_tscadc_data *data;
>  	int irq;
> -	int tsc_wires;
>  	struct mfd_cell cells[TSCADC_CELLS];
> +	u32 ctrl;
>  	u32 reg_se_cache;
>  	bool adc_waiting;
>  	bool adc_in_use;

