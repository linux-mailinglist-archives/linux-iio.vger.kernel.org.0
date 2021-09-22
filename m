Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F01414D42
	for <lists+linux-iio@lfdr.de>; Wed, 22 Sep 2021 17:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbhIVPnt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 22 Sep 2021 11:43:49 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:44515 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231712AbhIVPns (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 22 Sep 2021 11:43:48 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 512F1E0005;
        Wed, 22 Sep 2021 15:42:15 +0000 (UTC)
Date:   Wed, 22 Sep 2021 17:42:14 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Lee Jones <lee.jones@linaro.org>
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
Message-ID: <20210922174214.7aee560a@xps13>
In-Reply-To: <YUtFX/6I4VuBHXgf@google.com>
References: <20210915155908.476767-1-miquel.raynal@bootlin.com>
        <20210915155908.476767-18-miquel.raynal@bootlin.com>
        <YUtFX/6I4VuBHXgf@google.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Lee,

lee.jones@linaro.org wrote on Wed, 22 Sep 2021 16:01:51 +0100:

> On Wed, 15 Sep 2021, Miquel Raynal wrote:
> 
> > So far every sub-cell parameter in this driver was hardcoded: cell name,
> > cell compatible, specific clock name and desired clock frequency.
> > 
> > As we are about to introduce support for ADC1/magnetic reader, we need a
> > bit of flexibility. Let's add a driver data structure which will contain
> > these information.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  drivers/mfd/ti_am335x_tscadc.c       | 25 +++++++++++++++++++------
> >  include/linux/mfd/ti_am335x_tscadc.h |  9 +++++++++
> >  2 files changed, 28 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> > index ba821109e98b..fbc8e338188a 100644
> > --- a/drivers/mfd/ti_am335x_tscadc.c
> > +++ b/drivers/mfd/ti_am335x_tscadc.c
> > @@ -137,6 +137,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> >  		return -EINVAL;
> >  	}
> >  
> > +	tscadc->data = of_device_get_match_data(&pdev->dev);
> > +
> >  	node = of_get_child_by_name(pdev->dev.of_node, "tsc");
> >  	of_property_read_u32(node, "ti,wires", &tsc_wires);
> >  	of_property_read_u32(node, "ti,coordiante-readouts", &readouts);
> > @@ -212,7 +214,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> >  		goto err_disable_clk;
> >  	}
> >  
> > -	tscadc->clk_div = (clk_get_rate(clk) / ADC_CLK) - 1;
> > +	tscadc->clk_div = (clk_get_rate(clk) / tscadc->data->target_clk_rate) - 1;
> >  	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
> >  
> >  	/* Set the control register bits */
> > @@ -241,8 +243,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> >  	if (tsc_wires > 0) {
> >  		tscadc->tsc_cell = tscadc->used_cells;
> >  		cell = &tscadc->cells[tscadc->used_cells++];
> > -		cell->name = "TI-am335x-tsc";
> > -		cell->of_compatible = "ti,am3359-tsc";
> > +		cell->name = tscadc->data->name_tscmag;
> > +		cell->of_compatible = tscadc->data->compat_tscmag;
> >  		cell->platform_data = &tscadc;
> >  		cell->pdata_size = sizeof(tscadc);
> >  	}
> > @@ -251,8 +253,8 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> >  	if (adc_channels > 0) {
> >  		tscadc->adc_cell = tscadc->used_cells;
> >  		cell = &tscadc->cells[tscadc->used_cells++];
> > -		cell->name = "TI-am335x-adc";
> > -		cell->of_compatible = "ti,am3359-adc";
> > +		cell->name = tscadc->data->name_adc;
> > +		cell->of_compatible = tscadc->data->compat_adc;
> >  		cell->platform_data = &tscadc;
> >  		cell->pdata_size = sizeof(tscadc);
> >  	}
> > @@ -338,8 +340,19 @@ static int __maybe_unused tscadc_resume(struct device *dev)
> >  
> >  static SIMPLE_DEV_PM_OPS(tscadc_pm_ops, tscadc_suspend, tscadc_resume);
> >  
> > +static const struct ti_tscadc_data tscdata = {
> > +	.name_tscmag = "TI-am335x-tsc",
> > +	.compat_tscmag = "ti,am3359-tsc",
> > +	.name_adc = "TI-am335x-adc",
> > +	.compat_adc = "ti,am3359-adc",
> > +	.target_clk_rate = ADC_CLK,
> > +};
> > +
> >  static const struct of_device_id ti_tscadc_dt_ids[] = {
> > -	{ .compatible = "ti,am3359-tscadc", },
> > +	{
> > +		.compatible = "ti,am3359-tscadc",
> > +		.data = &tscdata,
> > +	},
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, ti_tscadc_dt_ids);
> > diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> > index ffc091b77633..0f581c15d95a 100644
> > --- a/include/linux/mfd/ti_am335x_tscadc.h
> > +++ b/include/linux/mfd/ti_am335x_tscadc.h
> > @@ -162,11 +162,20 @@
> >  
> >  #define TSCADC_CELLS		2
> >  
> > +struct ti_tscadc_data {
> > +	char *name_tscmag;
> > +	char *compat_tscmag;
> > +	char *name_adc;
> > +	char *compat_adc;  
> 
> I think these names should be improved.
> 
> What is tscmag?
> 
> Does that represent both the Magnetic Reader and the Touchscreen?

Not exactly, it represents *either* the magnetic reader *or* the
touchscreen.

Basically you can have either one version of the hardware which
is a regular ADC that can be also used as a touchscreen controller, or
you can have another version of the hardware which is a regular ADC
that can be also used as a magnetic reader.

Both features can be used as the same time (ts + adc or mag + adc),
hence we need a name for the touchscreen child node and for the adc
child node *or* a name for the magnetic reader chil node and for the adc
child node.

> If so, I'd prefer that you split them.  If not, I need more info.
> 
> For readability, I suggest;
> 
>   touchscreen_name
>   touchscreen_compatible
>   mag_reader_name
>   mag_reader_compatible
>   adc_name
>   adc_compatible
>   etc
> 

I can certainly improve the names though.

> What is a magnetic reader anyway?
> 
> Does it read the magnetic stripe on a payment card?

Yes!

> 
> > +	unsigned int target_clk_rate;
> > +};
> > +
> >  struct ti_tscadc_dev {
> >  	struct device *dev;
> >  	struct regmap *regmap;
> >  	void __iomem *tscadc_base;
> >  	phys_addr_t tscadc_phys_base;
> > +	const struct ti_tscadc_data *data;
> >  	int irq;
> >  	int used_cells;	/* 1-2 */
> >  	int tsc_wires;  
> 


Thanks,
Miquèl
