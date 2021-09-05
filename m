Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D127400FD7
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 15:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhIENNj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 09:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:36498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229759AbhIENNj (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 09:13:39 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2167960F45;
        Sun,  5 Sep 2021 13:12:29 +0000 (UTC)
Date:   Sun, 5 Sep 2021 14:15:52 +0100
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
Subject: Re: [PATCH v2 28/46] mfd: ti_am335x_tscadc: Add TSC prefix in
 certain macros
Message-ID: <20210905141552.14c282e9@jic23-huawei>
In-Reply-To: <20210902215144.507243-29-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
        <20210902215144.507243-29-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Sep 2021 23:51:26 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> While the register list (and names) between ADC0 and ADC1 are pretty
> close, the bits inside changed a little bit. To avoid any future
> confusion, let's add the TSC prefix when some bits are in a register
> that is common to both revisions of the ADC, but are specific to the
> am33xx hardware.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Given all I suggested last time was things you've done in earlier patches now
this LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/mfd/ti_am335x_tscadc.c       | 10 +++++-----
>  include/linux/mfd/ti_am335x_tscadc.h | 16 ++++++++--------
>  2 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index eba5fba8cf78..2fdee0f4814f 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -220,13 +220,13 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
>  
>  	/* Set the control register bits */
> -	tscadc->ctrl = CNTRLREG_STEPCONFIGWRT | CNTRLREG_STEPID;
> +	tscadc->ctrl = CNTRLREG_TSC_STEPCONFIGWRT | CNTRLREG_STEPID;
>  	if (tsc_wires > 0) {
> -		tscadc->ctrl |= CNTRLREG_TSCENB;
> +		tscadc->ctrl |= CNTRLREG_TSC_ENB;
>  		if (tsc_wires == 5)
> -			tscadc->ctrl |= CNTRLREG_5WIRE;
> +			tscadc->ctrl |= CNTRLREG_TSC_5WIRE;
>  		else
> -			tscadc->ctrl |= CNTRLREG_4WIRE;
> +			tscadc->ctrl |= CNTRLREG_TSC_4WIRE;
>  	}
>  	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
>  
> @@ -326,7 +326,7 @@ static const struct ti_tscadc_data tscdata = {
>  	.compat_tscmag = "ti,am3359-tsc",
>  	.name_adc = "TI-am335x-adc",
>  	.compat_adc = "ti,am3359-adc",
> -	.target_clk_rate = ADC_CLK,
> +	.target_clk_rate = TSC_ADC_CLK,
>  };
>  
>  static const struct of_device_id ti_tscadc_dt_ids[] = {
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index 271b5aefc474..29d3195b0193 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -113,14 +113,14 @@
>  /* Control register */
>  #define CNTRLREG_SSENB		BIT(0)
>  #define CNTRLREG_STEPID		BIT(1)
> -#define CNTRLREG_STEPCONFIGWRT	BIT(2)
> +#define CNTRLREG_TSC_STEPCONFIGWRT BIT(2)
>  #define CNTRLREG_POWERDOWN	BIT(4)
> -#define CNTRLREG_AFE_CTRL_MASK	GENMASK(6, 5)
> -#define CNTRLREG_AFE_CTRL(val)	FIELD_PREP(CNTRLREG_AFE_CTRL_MASK, (val))
> -#define CNTRLREG_4WIRE		CNTRLREG_AFE_CTRL(1)
> -#define CNTRLREG_5WIRE		CNTRLREG_AFE_CTRL(2)
> -#define CNTRLREG_8WIRE		CNTRLREG_AFE_CTRL(3)
> -#define CNTRLREG_TSCENB		BIT(7)
> +#define CNTRLREG_TSC_AFE_CTRL_MASK GENMASK(6, 5)
> +#define CNTRLREG_TSC_AFE_CTRL(val) FIELD_PREP(CNTRLREG_TSC_AFE_CTRL_MASK, (val))
> +#define CNTRLREG_TSC_4WIRE	CNTRLREG_TSC_AFE_CTRL(1)
> +#define CNTRLREG_TSC_5WIRE	CNTRLREG_TSC_AFE_CTRL(2)
> +#define CNTRLREG_TSC_8WIRE	CNTRLREG_TSC_AFE_CTRL(3)
> +#define CNTRLREG_TSC_ENB	BIT(7)
>  
>  /* FIFO READ Register */
>  #define FIFOREAD_DATA_MASK	GENMASK(11, 0)
> @@ -134,7 +134,7 @@
>  #define SEQ_STATUS		BIT(5)
>  #define CHARGE_STEP		0x11
>  
> -#define ADC_CLK			3000000
> +#define TSC_ADC_CLK		3000000
>  #define TOTAL_STEPS		16
>  #define TOTAL_CHANNELS		8
>  #define FIFO1_THRESHOLD		19

