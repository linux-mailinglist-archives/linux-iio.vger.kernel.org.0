Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F673FF488
	for <lists+linux-iio@lfdr.de>; Thu,  2 Sep 2021 22:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343763AbhIBUEi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 2 Sep 2021 16:04:38 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:54915 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343608AbhIBUEi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Sep 2021 16:04:38 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 95CE71BF203;
        Thu,  2 Sep 2021 20:03:35 +0000 (UTC)
Date:   Thu, 2 Sep 2021 22:03:34 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Jonathan Cameron <jic23@kernel.org>
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
Message-ID: <20210902220334.2abd0083@xps13>
In-Reply-To: <20210830151010.7dcb1be3@jic23-huawei>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-29-miquel.raynal@bootlin.com>
        <20210830151010.7dcb1be3@jic23-huawei>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,


> > +static const struct ti_tscadc_data magdata = {
> > +	.has_tsc = false,
> > +	.has_mag = true,
> > +	.name_tscmag = "TI-am43xx-mag",
> > +	.compat_tscmag = "ti,am4372-mag",
> > +	.name_adc = "TI-am43xx-adc",
> > +	.compat_adc = "ti,am4372-adc",
> > +	.target_clk_rate = MAG_ADC_CLK,
> > +};
> > +
> >  static const struct of_device_id ti_tscadc_dt_ids[] = {
> > -	{ .compatible = "ti,am3359-tscadc", },
> > +	{
> > +		.compatible = "ti,am3359-tscadc",
> > +		.data = &tscdata,  
> Interesting to see match data added here and not before.
> Given you don't have any code in here that seems to have
> changed to use the match data, was it buggy before or is this still
> not used?

As said earlier, it was buggy before. It is now fixed.

> 
> > +	},
> > +	{
> > +		.compatible = "ti,am4372-magadc",
> > +		.data = &magdata,
> > +	},
> >  	{ }
> >  };
> >  MODULE_DEVICE_TABLE(of, ti_tscadc_dt_ids);
> > @@ -355,6 +382,6 @@ static struct platform_driver ti_tscadc_driver = {
> >  
> >  module_platform_driver(ti_tscadc_driver);
> >  
> > -MODULE_DESCRIPTION("TI touchscreen / ADC MFD controller driver");
> > +MODULE_DESCRIPTION("TI touchscreen/magnetic reader/ADC MFD controller driver");
> >  MODULE_AUTHOR("Rachna Patil <rachna@ti.com>");
> >  MODULE_LICENSE("GPL");
> > diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> > index 082b2af94263..31b22ec567e7 100644
> > --- a/include/linux/mfd/ti_am335x_tscadc.h
> > +++ b/include/linux/mfd/ti_am335x_tscadc.h
> > @@ -129,6 +129,11 @@
> >  #define CNTRLREG_TSC_8WIRE	CNTRLREG_TSC_AFE_CTRL(3)
> >  #define CNTRLREG_TSC_ENB	BIT(7)
> >  
> > +/*Control registers bitfields  for MAGADC IP */
> > +#define CNTRLREG_MAGADCENB      BIT(0)
> > +#define CNTRLREG_MAG_PREAMP_PWRDOWN BIT(5)
> > +#define CNTRLREG_MAG_PREAMP_BYPASS  BIT(6)
> > +
> >  /* FIFO READ Register */
> >  #define FIFOREAD_DATA_MASK (0xfff << 0)
> >  #define FIFOREAD_CHNLID_MASK (0xf << 16)
> > @@ -141,7 +146,8 @@
> >  #define SEQ_STATUS BIT(5)
> >  #define CHARGE_STEP		0x11
> >  
> > -#define TSC_ADC_CLK		3000000
> > +#define TSC_ADC_CLK		3000000 /* 3 MHz */
> > +#define MAG_ADC_CLK		13000000 /* 13 MHz */  
> 
> Not sure on current status, but there is a proposed series floating
> about that adds HZ_PER_MEGAHZ or something like that which would make
> it easier to spot if these have right number of zeros.

Would be nice indeed, but it looks like it's not yet mainline :/

Thanks,
Miquèl
