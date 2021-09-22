Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AD4414D9D
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 18:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbhIVQBz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 12:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhIVQBy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 12:01:54 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53030C061574
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 09:00:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u18so8349497wrg.5
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DitKZE2YmWLcJhuWMyY4UnlFA8GEl2HgFvdNE+mZ/C0=;
        b=V5kxa8UE7c9SriJCPTT4HCGoH4VIBUBl3t+jA75xR9sbHvoJgrdWmSFn24hkGvG4LG
         P0gzNWfw2nlSWY3IWetSvxo6hj3PYUPJwi8U/hkoXcSp0PaOR2THLJ27rAKQXsYav0kJ
         SN/edZWj4koqLN/qFzKHESyyE85E4SsiXghhKayI8WeEc+g+/QJJM6arUklfpVnDMhbK
         0BFW3XDFTb3vC9485ykByHDD2zFaT6gn98GEZ5FQMDQak9OeD+88GQy4drcGxK3Uf9J/
         +k9N8FFlL8U3dZlZS41mRClk/IW7Q+iySTtAOCJCEMEK7lEBqEC8UHP00/5SH7MPvhKF
         K3gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DitKZE2YmWLcJhuWMyY4UnlFA8GEl2HgFvdNE+mZ/C0=;
        b=ITkYh/nN+rd2ve6eZgBtJ4UgofZGGdQg4wYWEY1ejDa04hVnlu3mahQNWXvfQr4nad
         YikmPc1oKdT7b5/HYm+SUjvR9ujMJMiqMhqcStRX3m0Xsb4Jc+qCSq80rzkEy87Oxapf
         Jp9DFSwPWsalEu4hgKBLM+ko7AYd8tcE4cziTlXZ7gCYHnp0JseNwprNf7k+eqfgstpk
         Q+sUdfO8ZpxGQ5V7Zer/4lwHKaLomM8AwyQcAiLX+oN/DVdEq0Dxyw7f+o5io7f5RNBi
         oMENTz0GGmbvHEHdQbZxSNDwjSucFQr7xMkQiqihY2kBV++Nb8GCRKInPRAN7YpV3Hu4
         mG0Q==
X-Gm-Message-State: AOAM533iu9asLAB9E9W7B4FL66Xprbcz/VVe55udTebYk+730lHfio1V
        yjOJQMCmE8kY3xH1Qtggy82c3g==
X-Google-Smtp-Source: ABdhPJxbMEbMQjPi/IqDVryc7t9gwWZEDQkQ2K+3oGZELjX7u7znm2vKuef1dzJuZV4acI1825kGIg==
X-Received: by 2002:a1c:149:: with SMTP id 70mr11141227wmb.187.1632326422787;
        Wed, 22 Sep 2021 09:00:22 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id f19sm2407217wmf.11.2021.09.22.09.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 09:00:22 -0700 (PDT)
Date:   Wed, 22 Sep 2021 17:00:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        bcousson@baylibre.com, Tony Lindgren <tony@atomide.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Ryan Barnett <ryan.barnett@collins.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Jason Reeder <jreeder@ti.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 35/47] mfd: ti_am335x_tscadc: Add ADC1/magnetic reader
 support
Message-ID: <YUtTFEv1YFOMeuEb@google.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
 <20210915155908.476767-36-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210915155908.476767-36-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Sep 2021, Miquel Raynal wrote:

> Introduce a new compatible that has another set of driver data,
> targeting am437x SoCs with a magnetic reader instead of the
> touchscreen and a more featureful set of registers.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c       | 41 ++++++++++++++++++++++++----
>  include/linux/mfd/ti_am335x_tscadc.h |  7 +++++
>  2 files changed, 42 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index 65c0fa735a71..155a8ed879b3 100644
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
> @@ -209,8 +219,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
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
> @@ -238,6 +249,9 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
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

Why 2 bools?

Better to have a single u8:

  MODE_TOUCHSCREEN
  MODE_MAG_STRING
  MODE_NONE

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

Magnetic what?  Tape, disk, stripe?

>  MODULE_AUTHOR("Rachna Patil <rachna@ti.com>");
>  MODULE_LICENSE("GPL");
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index 467b3bec4335..9a412e6d764b 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -106,6 +106,11 @@
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
> @@ -119,6 +124,7 @@
>  #define CHARGE_STEP		0x11
>  
>  #define TSC_ADC_CLK		(3 * HZ_PER_MHZ)
> +#define MAG_ADC_CLK		(13 * HZ_PER_MHZ)
>  #define TOTAL_STEPS		16
>  #define TOTAL_CHANNELS		8
>  #define FIFO1_THRESHOLD		19
> @@ -141,6 +147,7 @@
>  
>  struct ti_tscadc_data {
>  	bool has_tsc;
> +	bool has_mag;
>  	char *name_tscmag;
>  	char *compat_tscmag;
>  	char *name_adc;

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
