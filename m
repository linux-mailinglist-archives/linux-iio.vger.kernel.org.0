Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719EA3FB780
	for <lists+linux-iio@lfdr.de>; Mon, 30 Aug 2021 16:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236877AbhH3OIA (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 30 Aug 2021 10:08:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:56316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229710AbhH3OH6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 30 Aug 2021 10:07:58 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AF8C60F3A;
        Mon, 30 Aug 2021 14:06:58 +0000 (UTC)
Date:   Mon, 30 Aug 2021 15:10:10 +0100
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
Subject: Re: [PATCH 28/40] mfd: ti_am335x_tscadc: Add ADC1/magnetic reader
 support
Message-ID: <20210830151010.7dcb1be3@jic23-huawei>
In-Reply-To: <20210825152518.379386-29-miquel.raynal@bootlin.com>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-29-miquel.raynal@bootlin.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 25 Aug 2021 17:25:06 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Introduce a new compatible that has another set of driver data,
> targeting am437x SoCs with a magnetic reader instead of the
> touchscreen and a more featureful set of registers.
> 
> Co-developed-by: Jason Reeder <jreeder@ti.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Jason Reeder <jreeder@ti.com>
There is one bit in here that I think should have been back in patch 16 but
maybe I'm missing something.

Jonathan

> ---
>  drivers/mfd/ti_am335x_tscadc.c       | 43 ++++++++++++++++++++++------
>  include/linux/mfd/ti_am335x_tscadc.h |  9 +++++-
>  2 files changed, 43 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 1a30610dc65f..f4f6b9db4d2a 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -122,9 +122,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	const __be32 *cur;
>  	struct clk *clk;
>  	u32 val;
> -	bool use_tsc = false;
> +	bool use_tsc = false, use_mag = false;
>  	int tscmag_wires = 0, adc_channels = 0, readouts = 0, cell_idx = 0;
> -	int total_channels, err;
> +	int mag_tracks = 0, total_channels, err;
>  
>  	/* Allocate memory for device */
>  	tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
> @@ -146,6 +146,12 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  		of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
>  		if (tscmag_wires)
>  			use_tsc = true;
> +	} else {
> +		node = of_get_child_by_name(pdev->dev.of_node, "mag");
> +		of_property_read_u32(node, "ti,tracks", &mag_tracks);
> +		tscmag_wires = mag_tracks * 2;
> +		if (tscmag_wires)
> +			use_mag = true;
>  	}
>  
>  	node = of_get_child_by_name(pdev->dev.of_node, "adc");
> @@ -206,8 +212,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
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
> @@ -231,7 +238,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  			else
>  				tscadc->ctrl |= CNTRLREG_TSC_4WIRE;
>  		}
> -
> +	} else {
> +		tscadc->ctrl |= CNTRLREG_MAG_PREAMP_PWRDOWN |
> +				CNTRLREG_MAG_PREAMP_BYPASS;
>  	}
>  
>  	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
> @@ -241,7 +250,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	/* Enable the TSC module enable bit */
>  	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_SSENB);
>  
> -	/* TSC Cell */
> +	/* TSC or MAG Cell */
>  	if (tscmag_wires > 0) {
>  		cell = &tscadc->cells[cell_idx++];
>  		cell->name = tscadc->data->name_tscmag;
> @@ -329,6 +338,7 @@ static SIMPLE_DEV_PM_OPS(tscadc_pm_ops, tscadc_suspend, tscadc_resume);
>  
>  static const struct ti_tscadc_data tscdata = {
>  	.has_tsc = true,
> +	.has_mag = false,
>  	.name_tscmag = "TI-am335x-tsc",
>  	.compat_tscmag = "ti,am3359-tsc",
>  	.name_adc = "TI-am335x-adc",
> @@ -336,8 +346,25 @@ static const struct ti_tscadc_data tscdata = {
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
> -	{ .compatible = "ti,am3359-tscadc", },
> +	{
> +		.compatible = "ti,am3359-tscadc",
> +		.data = &tscdata,
Interesting to see match data added here and not before.
Given you don't have any code in here that seems to have
changed to use the match data, was it buggy before or is this still
not used?

> +	},
> +	{
> +		.compatible = "ti,am4372-magadc",
> +		.data = &magdata,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ti_tscadc_dt_ids);
> @@ -355,6 +382,6 @@ static struct platform_driver ti_tscadc_driver = {
>  
>  module_platform_driver(ti_tscadc_driver);
>  
> -MODULE_DESCRIPTION("TI touchscreen / ADC MFD controller driver");
> +MODULE_DESCRIPTION("TI touchscreen/magnetic reader/ADC MFD controller driver");
>  MODULE_AUTHOR("Rachna Patil <rachna@ti.com>");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index 082b2af94263..31b22ec567e7 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -129,6 +129,11 @@
>  #define CNTRLREG_TSC_8WIRE	CNTRLREG_TSC_AFE_CTRL(3)
>  #define CNTRLREG_TSC_ENB	BIT(7)
>  
> +/*Control registers bitfields  for MAGADC IP */
> +#define CNTRLREG_MAGADCENB      BIT(0)
> +#define CNTRLREG_MAG_PREAMP_PWRDOWN BIT(5)
> +#define CNTRLREG_MAG_PREAMP_BYPASS  BIT(6)
> +
>  /* FIFO READ Register */
>  #define FIFOREAD_DATA_MASK (0xfff << 0)
>  #define FIFOREAD_CHNLID_MASK (0xf << 16)
> @@ -141,7 +146,8 @@
>  #define SEQ_STATUS BIT(5)
>  #define CHARGE_STEP		0x11
>  
> -#define TSC_ADC_CLK		3000000
> +#define TSC_ADC_CLK		3000000 /* 3 MHz */
> +#define MAG_ADC_CLK		13000000 /* 13 MHz */

Not sure on current status, but there is a proposed series floating
about that adds HZ_PER_MEGAHZ or something like that which would make
it easier to spot if these have right number of zeros.

>  #define TOTAL_STEPS		16
>  #define TOTAL_CHANNELS		8
>  #define FIFO1_THRESHOLD		19
> @@ -164,6 +170,7 @@
>  
>  struct ti_tscadc_data {
>  	bool has_tsc;
> +	bool has_mag;
>  	char *name_tscmag;
>  	char *compat_tscmag;
>  	char *name_adc;

