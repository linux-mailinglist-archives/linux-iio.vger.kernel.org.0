Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6153F400FE9
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 15:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhIENVL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Sep 2021 09:21:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229583AbhIENVK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 09:21:10 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69A9860F45;
        Sun,  5 Sep 2021 13:20:01 +0000 (UTC)
Date:   Sun, 5 Sep 2021 14:23:24 +0100
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
Subject: Re: [PATCH v2 34/46] mfd: ti_am335x_tscadc: Add ADC1/magnetic
 reader support
Message-ID: <20210905142324.3de19916@jic23-huawei>
In-Reply-To: <20210902215144.507243-35-miquel.raynal@bootlin.com>
References: <20210902215144.507243-1-miquel.raynal@bootlin.com>
        <20210902215144.507243-35-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  2 Sep 2021 23:51:32 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Introduce a new compatible that has another set of driver data,
> targeting am437x SoCs with a magnetic reader instead of the
> touchscreen and a more featureful set of registers.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
I'm being lazy and not datasheet diving but otherwise looks good.
The HZ unit patch is in mm, but Linus hasn't merged it yet.  May well be
in whatever tree this goes into post merge window though.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/mfd/ti_am335x_tscadc.c       | 41 ++++++++++++++++++++++++----
>  include/linux/mfd/ti_am335x_tscadc.h |  9 +++++-
>  2 files changed, 43 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index a0db3e4ff265..a3347f9fc388 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -121,11 +121,11 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	struct mfd_cell *cell;
>  	struct property *prop;
>  	const __be32 *cur;
> -	bool use_tsc = false;
> +	bool use_tsc = false, use_mag = false;
>  	u32 val;
>  	int err;
>  	int tscmag_wires = 0, adc_channels = 0, cell_idx = 0, total_channels;
> -	int readouts = 0;
> +	int readouts = 0, mag_tracks = 0;
>  
>  	/* Allocate memory for device */
>  	tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
> @@ -148,6 +148,16 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  		of_node_put(node);
>  		if (tscmag_wires)
>  			use_tsc = true;
> +	} else {
> +		/*
> +		 * When adding support for the magnetic reader, here is the
> +		 * place to look for the number of tracks used from device tree.
> +		 * Let's default to 0 for now.
> +		 */
> +		mag_tracks = 0;
> +		tscmag_wires = mag_tracks * 2;
> +		if (tscmag_wires)
> +			use_mag = true;
>  	}
>  
>  	node = of_get_child_by_name(pdev->dev.of_node, "adc");
> @@ -211,8 +221,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	 * The TSC_ADC_Subsystem has 2 clock domains: OCP_CLK and ADC_CLK.
>  	 * ADCs produce a 12-bit sample every 15 ADC_CLK cycles.
>  	 * am33xx ADCs expect to capture 200ksps.
> -	 * We need the ADC clocks to run at 3MHz.
> -	 * This frequency is valid since TSC_ADC_SS controller design
> +	 * am47xx ADCs expect to capture 867ksps.
> +	 * We need ADC clocks respectively running at 3MHz and 13MHz.
> +	 * These frequencies are valid since TSC_ADC_SS controller design
>  	 * assumes the OCP clock is at least 6x faster than the ADC clock.
>  	 */
>  	clk = devm_clk_get(&pdev->dev, NULL);
> @@ -236,6 +247,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  			else
>  				tscadc->ctrl |= CNTRLREG_TSC_4WIRE;
>  		}
> +	} else {
> +		tscadc->ctrl |= CNTRLREG_MAG_PREAMP_PWRDOWN |
> +				CNTRLREG_MAG_PREAMP_BYPASS;
>  	}
>  	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
>  
> @@ -246,7 +260,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	/* Enable the TSC module enable bit */
>  	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_SSENB);
>  
> -	/* TSC Cell */
> +	/* TSC or MAG Cell */
>  	if (tscmag_wires > 0) {
>  		cell = &tscadc->cells[cell_idx++];
>  		cell->name = tscadc->data->name_tscmag;
> @@ -334,6 +348,7 @@ static SIMPLE_DEV_PM_OPS(tscadc_pm_ops, tscadc_suspend, tscadc_resume);
>  
>  static const struct ti_tscadc_data tscdata = {
>  	.has_tsc = true,
> +	.has_mag = false,
>  	.name_tscmag = "TI-am335x-tsc",
>  	.compat_tscmag = "ti,am3359-tsc",
>  	.name_adc = "TI-am335x-adc",
> @@ -341,11 +356,25 @@ static const struct ti_tscadc_data tscdata = {
>  	.target_clk_rate = TSC_ADC_CLK,
>  };
>  
> +static const struct ti_tscadc_data magdata = {
> +	.has_tsc = false,
> +	.has_mag = true,
> +	.name_tscmag = "TI-am43xx-mag",
> +	.compat_tscmag = "ti,am4372-mag",
> +	.name_adc = "TI-am43xx-adc",
> +	.compat_adc = "ti,am4372-adc",
> +	.target_clk_rate = MAG_ADC_CLK,
> +};
> +
>  static const struct of_device_id ti_tscadc_dt_ids[] = {
>  	{
>  		.compatible = "ti,am3359-tscadc",
>  		.data = &tscdata,
>  	},
> +	{
> +		.compatible = "ti,am4372-magadc",
> +		.data = &magdata,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ti_tscadc_dt_ids);
> @@ -363,6 +392,6 @@ static struct platform_driver ti_tscadc_driver = {
>  
>  module_platform_driver(ti_tscadc_driver);
>  
> -MODULE_DESCRIPTION("TI touchscreen / ADC MFD controller driver");
> +MODULE_DESCRIPTION("TI touchscreen/magnetic reader/ADC MFD controller driver");
>  MODULE_AUTHOR("Rachna Patil <rachna@ti.com>");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index 3dbdb827566c..1f29bcdf51c7 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -122,6 +122,11 @@
>  #define CNTRLREG_TSC_8WIRE	CNTRLREG_TSC_AFE_CTRL(3)
>  #define CNTRLREG_TSC_ENB	BIT(7)
>  
> +/*Control registers bitfields  for MAGADC IP */
> +#define CNTRLREG_MAGADCENB      BIT(0)
> +#define CNTRLREG_MAG_PREAMP_PWRDOWN BIT(5)
> +#define CNTRLREG_MAG_PREAMP_BYPASS  BIT(6)
> +
>  /* FIFO READ Register */
>  #define FIFOREAD_DATA_MASK	GENMASK(11, 0)
>  #define FIFOREAD_CHNLID_MASK	GENMASK(19, 16)
> @@ -134,7 +139,8 @@
>  #define SEQ_STATUS		BIT(5)
>  #define CHARGE_STEP		0x11
>  
> -#define TSC_ADC_CLK		3000000
> +#define TSC_ADC_CLK		3000000 /* 3 MHz */
> +#define MAG_ADC_CLK		13000000 /* 13 MHz */
>  #define TOTAL_STEPS		16
>  #define TOTAL_CHANNELS		8
>  #define FIFO1_THRESHOLD		19
> @@ -157,6 +163,7 @@
>  
>  struct ti_tscadc_data {
>  	bool has_tsc;
> +	bool has_mag;
>  	char *name_tscmag;
>  	char *compat_tscmag;
>  	char *name_adc;

