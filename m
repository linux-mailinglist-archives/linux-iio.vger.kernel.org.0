Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D299414D7E
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 17:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236440AbhIVPzx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 22 Sep 2021 11:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbhIVPzw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 11:55:52 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F961C061757
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 08:54:22 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id d6so8166501wrc.11
        for <linux-iio@vger.kernel.org>; Wed, 22 Sep 2021 08:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=PLbI3wSn9/WzdqFLGwBImkDbqbOcjXrs2wkrBMt5oVs=;
        b=APe/O9KSRHq74QO27eoEqtZXLJHDNIGTCezBdYQtSV68+mWsjN4CSodceGeIe1mF4n
         Lfdu/423t5f6UuPc5Nygjpw95OlUts/ynku0Ttxqls5rXQr5DcTL1frYGEtPaotXJB2A
         Y/+DVBTc8Uy1k2TrPdpSuw1N9DtLbwd3WC7H6lz8F4f107UuHsT5L0P2hXRWWtS0ulcJ
         kRBLTRgdmkynDIxuEDcJkHXSJUkpW9JtTNNqZyAOeIpVqVOGGk2AqBDXMiRIb7XtbzmH
         S7dyfX5pY1qQPx/wRiGANEyAiPj8fiKZwcI7x07YPEST50mKxZ3l3UiCUKtGXWB4bx13
         vUTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PLbI3wSn9/WzdqFLGwBImkDbqbOcjXrs2wkrBMt5oVs=;
        b=OmVUlmXOV224rtpQfJaNLX4XCx0lPq7KTiJotjd2kgTrIypvVXD//33aRWiEnHNn+h
         TkFpHAJjYBmS4gaHfcr0J5SMZ/mgjY6XECV76Nvrsw7RzSxvgd+NtdfCNk/SGm+uGM8Y
         AZVy6752wQOwFXHlPlqj6wplviHj2bIYP4N3HVuujQ/XwUHK5ONTEoW81c7k7e3igHOf
         eD8jVnDE61efUzQI1aNGQSo9U0BXD/6KunS+8empb9ahc+eVrDrGUlfWHs2sAnCO4uei
         H57S2amQU5eUFXdmFCPDWHZIHM3bQPmlaNE73mn/QNotWweHB5S5mwsqrrPKPT8b/bzu
         xTXw==
X-Gm-Message-State: AOAM530jB+4b4nQVhr6E76KGVTNkd6AcAVy6TsrklF8fu7E/lkPe5nOX
        K08DQJnZkAVVvLlxyHVXoZGQNQ==
X-Google-Smtp-Source: ABdhPJwAyYxGmgS0bVREy09SNnmC7r57WNiWJq4WiyZRRosVw45+q3BPze1ZqtSQYYQ/y12iFrlr/g==
X-Received: by 2002:a7b:ce91:: with SMTP id q17mr105379wmj.25.1632326060980;
        Wed, 22 Sep 2021 08:54:20 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id k4sm2457787wmj.30.2021.09.22.08.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 08:54:20 -0700 (PDT)
Date:   Wed, 22 Sep 2021 16:54:18 +0100
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
Message-ID: <YUtRqsmW8UX+yVpv@google.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
 <20210915155908.476767-18-miquel.raynal@bootlin.com>
 <YUtFX/6I4VuBHXgf@google.com>
 <20210922174214.7aee560a@xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210922174214.7aee560a@xps13>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Sep 2021, Miquel Raynal wrote:

> Hi Lee,
> 
> lee.jones@linaro.org wrote on Wed, 22 Sep 2021 16:01:51 +0100:
> 
> > On Wed, 15 Sep 2021, Miquel Raynal wrote:
> > 
> > > So far every sub-cell parameter in this driver was hardcoded: cell name,
> > > cell compatible, specific clock name and desired clock frequency.
> > > 
> > > As we are about to introduce support for ADC1/magnetic reader, we need a
> > > bit of flexibility. Let's add a driver data structure which will contain
> > > these information.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >  drivers/mfd/ti_am335x_tscadc.c       | 25 +++++++++++++++++++------
> > >  include/linux/mfd/ti_am335x_tscadc.h |  9 +++++++++
> > >  2 files changed, 28 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> > > index ba821109e98b..fbc8e338188a 100644
> > > --- a/drivers/mfd/ti_am335x_tscadc.c
> > > +++ b/drivers/mfd/ti_am335x_tscadc.c
> > > @@ -137,6 +137,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> > >  		return -EINVAL;
> > >  	}
> > >  
> > > +	tscadc->data = of_device_get_match_data(&pdev->dev);
> > > +
> > >  	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
> > >  	of_property_read_u32(node, "ti,wires", &tsc_wires);
> > >  	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
> > > @@ -212,7 +214,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> > >  		goto err_disable_clk;
> > >  	}
> > >  
> > > -	tscadc->clk_div = (clk_get_rate(clk) / ADC_CLK) - 1;
> > > +	tscadc->clk_div = (clk_get_rate(clk) / tscadc->data->target_clk_rate) - 1;
> > >  	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
> > >  
> > >  	/* Set the control register bits */
> > > @@ -241,8 +243,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> > >  	if (tsc_wires > 0) {
> > >  		tscadc->tsc_cell = tscadc->used_cells;
> > >  		cell = &tscadc->cells[tscadc->used_cells++];
> > > -		cell->name = "TI-am335x-tsc";
> > > -		cell->of_compatible = "ti,am3359-tsc";
> > > +		cell->name = tscadc->data->name_tscmag;
> > > +		cell->of_compatible = tscadc->data->compat_tscmag;
> > >  		cell->platform_data = &tscadc;
> > >  		cell->pdata_size = sizeof(tscadc);
> > >  	}
> > > @@ -251,8 +253,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> > >  	if (adc_channels > 0) {
> > >  		tscadc->adc_cell = tscadc->used_cells;
> > >  		cell = &tscadc->cells[tscadc->used_cells++];
> > > -		cell->name = "TI-am335x-adc";
> > > -		cell->of_compatible = "ti,am3359-adc";
> > > +		cell->name = tscadc->data->name_adc;
> > > +		cell->of_compatible = tscadc->data->compat_adc;
> > >  		cell->platform_data = &tscadc;
> > >  		cell->pdata_size = sizeof(tscadc);
> > >  	}
> > > @@ -338,8 +340,19 @@ static int __maybe_unused tscadc_resume(struct device *dev)
> > >  
> > >  static SIMPLE_DEV_PM_OPS(tscadc_pm_ops, tscadc_suspend, tscadc_resume);
> > >  
> > > +static const struct ti_tscadc_data tscdata = {
> > > +	.name_tscmag = "TI-am335x-tsc",
> > > +	.compat_tscmag = "ti,am3359-tsc",
> > > +	.name_adc = "TI-am335x-adc",
> > > +	.compat_adc = "ti,am3359-adc",
> > > +	.target_clk_rate = ADC_CLK,
> > > +};
> > > +
> > >  static const struct of_device_id ti_tscadc_dt_ids[] = {
> > > -	{ .compatible = "ti,am3359-tscadc", },
> > > +	{
> > > +		.compatible = "ti,am3359-tscadc",
> > > +		.data = &tscdata,
> > > +	},
> > >  	{ }
> > >  };
> > >  MODULE_DEVICE_TABLE(of, ti_tscadc_dt_ids);
> > > diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> > > index ffc091b77633..0f581c15d95a 100644
> > > --- a/include/linux/mfd/ti_am335x_tscadc.h
> > > +++ b/include/linux/mfd/ti_am335x_tscadc.h
> > > @@ -162,11 +162,20 @@
> > >  
> > >  #define TSCADC_CELLS		2
> > >  
> > > +struct ti_tscadc_data {
> > > +	char *name_tscmag;
> > > +	char *compat_tscmag;
> > > +	char *name_adc;
> > > +	char *compat_adc;  
> > 
> > I think these names should be improved.
> > 
> > What is tscmag?
> > 
> > Does that represent both the Magnetic Reader and the Touchscreen?
> 
> Not exactly, it represents *either* the magnetic reader *or* the
> touchscreen.
> 
> Basically you can have either one version of the hardware which
> is a regular ADC that can be also used as a touchscreen controller, or
> you can have another version of the hardware which is a regular ADC
> that can be also used as a magnetic reader.
> 
> Both features can be used as the same time (ts + adc or mag + adc),
> hence we need a name for the touchscreen child node and for the adc
> child node *or* a name for the magnetic reader chil node and for the adc
> child node.
> 
> > If so, I'd prefer that you split them.  If not, I need more info.
> > 
> > For readability, I suggest;
> > 
> >   touchscreen_name
> >   touchscreen_compatible
> >   mag_reader_name
> >   mag_reader_compatible
> >   adc_name
> >   adc_compatible
> >   etc
> > 
> 
> I can certainly improve the names though.

Thanks.

> > What is a magnetic reader anyway?
> > 
> > Does it read the magnetic stripe on a payment card?
> 
> Yes!

The mag_stripe_reader might be nice.

> > > +	unsigned int target_clk_rate;
> > > +};
> > > +
> > >  struct ti_tscadc_dev {
> > >  	struct device *dev;
> > >  	struct regmap *regmap;
> > >  	void __iomem *tscadc_base;
> > >  	phys_addr_t tscadc_phys_base;
> > > +	const struct ti_tscadc_data *data;
> > >  	int irq;
> > >  	int used_cells;	/* 1-2 */
> > >  	int tsc_wires;  
> > 
> 
> 
> Thanks,
> Miquèl

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
