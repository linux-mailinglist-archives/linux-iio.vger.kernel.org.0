Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56A3414CA2
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 17:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236356AbhIVPD1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 11:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbhIVPD0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 11:03:26 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C724C061756
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 08:01:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id w29so7710672wra.8
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 08:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e/8vlf6ZJGgT0nFK3H9I5QV9du1gDdHD92jDJeZbQnc=;
        b=MrlCvM9fTVPK8UCQ3ZxglrH5BVRHqFmwHH7UebhoEibKMzIZsiLnkPD0iV3IkXJ2Lu
         fhBXkvjUdg5gu40HiSHO+iwclKd92Rpp5NPeFExco+d9VFcte+3WhPmVbYmavZ1kSt7b
         dwf4uxU1tMuTISLUpHeiaMQviDQ5UVW7awBdvuGWiOpj/lFSR8wDmkXYE7zrK+9r7p3q
         LKVJy/sMWgy58vzyNFzJ2E8IdmGV1a/LE0c/ceQ2TnJhN5KPXzj9qecT8ghg//a2pSpF
         UbdKpjfeKu3topNapIKUrSkejYg7LTtonUC/oJOrgnfuFinh90yS774S2xvQGqAYlKjb
         OmOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e/8vlf6ZJGgT0nFK3H9I5QV9du1gDdHD92jDJeZbQnc=;
        b=InSoxMhdlA8qYMhbCGHJKSd6tBXL8kVPq8V9/wVYKTI1F6ffzUBeEV56vmg/UgP4Yp
         /W3UGrxfXtAEYB2EicT+kBqaVO34VC50Z0gJuSPuLFFulJE/H9be5zuuLfAhn6Bn3HhU
         M8eU/hS4T5aGqJaqk4P00TUAna+1Vp9yX0Mm9T4D8vVsQiAZF9+XcERyk2IUrIa+8K/R
         0iadFOUw8sWtXv3sq8ShED5nTOCQ2SwwJpg0DkIvFI2yKO8DiwELJNVwTKD5bHHsHoHe
         NRNjNZn7riMiNGXb3v3QGkna+wD7lq8fvmmW57vBtzM3odRxnEJe4mtScMWxcZBWdUqF
         7E0Q==
X-Gm-Message-State: AOAM530n9nCC91+is7ymwS2IHPcHl44Y9cSCiW1zBif8hVTikmZvoX0O
        RyWFMVpVcPVddoSR531AT6bKRA==
X-Google-Smtp-Source: ABdhPJy8lhd5Xbf6p0Cw8bQC6TWALcWr6/FiKINfo9OvwSibxVc/vVq99NAlmqvZoMQd5Mb+BoI0xw==
X-Received: by 2002:a05:600c:22d6:: with SMTP id 22mr11062985wmg.17.1632322914822;
        Wed, 22 Sep 2021 08:01:54 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id k6sm5942844wmo.37.2021.09.22.08.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 08:01:53 -0700 (PDT)
Date:   Wed, 22 Sep 2021 16:01:51 +0100
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
Subject: Re: [PATCH v3 17/47] mfd: ti_am335x_tscadc: Use driver data
Message-ID: <YUtFX/6I4VuBHXgf@google.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
 <20210915155908.476767-18-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210915155908.476767-18-miquel.raynal@bootlin.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Sep 2021, Miquel Raynal wrote:

> So far every sub-cell parameter in this driver was hardcoded: cell name,
> cell compatible, specific clock name and desired clock frequency.
> 
> As we are about to introduce support for ADC1/magnetic reader, we need a
> bit of flexibility. Let's add a driver data structure which will contain
> these information.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/mfd/ti_am335x_tscadc.c       | 25 +++++++++++++++++++------
>  include/linux/mfd/ti_am335x_tscadc.h |  9 +++++++++
>  2 files changed, 28 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index ba821109e98b..fbc8e338188a 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -137,6 +137,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  		return -EINVAL;
>  	}
>  
> +	tscadc->data = of_device_get_match_data(&pdev->dev);
> +
>  	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
>  	of_property_read_u32(node, "ti,wires", &tsc_wires);
>  	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
> @@ -212,7 +214,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  		goto err_disable_clk;
>  	}
>  
> -	tscadc->clk_div = (clk_get_rate(clk) / ADC_CLK) - 1;
> +	tscadc->clk_div = (clk_get_rate(clk) / tscadc->data->target_clk_rate) - 1;
>  	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
>  
>  	/* Set the control register bits */
> @@ -241,8 +243,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
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
> @@ -251,8 +253,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
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
> @@ -338,8 +340,19 @@ static int __maybe_unused tscadc_resume(struct device *dev)
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
> -	{ .compatible = "ti,am3359-tscadc", },
> +	{
> +		.compatible = "ti,am3359-tscadc",
> +		.data = &tscdata,
> +	},
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ti_tscadc_dt_ids);
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

I think these names should be improved.

What is tscmag?

Does that represent both the Magnetic Reader and the Touchscreen?

If so, I'd prefer that you split them.  If not, I need more info.

For readability, I suggest;

  touchscreen_name
  touchscreen_compatible
  mag_reader_name
  mag_reader_compatible
  adc_name
  adc_compatible
  etc

What is a magnetic reader anyway?

Does it read the magnetic stripe on a payment card?

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

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
