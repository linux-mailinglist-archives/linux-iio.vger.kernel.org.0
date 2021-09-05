Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9BA400F3B
	for <lists+linux-iio@lfdr.de>; Sun,  5 Sep 2021 13:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbhIELLK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 5 Sep 2021 07:11:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237534AbhIELLJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 5 Sep 2021 07:11:09 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22F4260F22;
        Sun,  5 Sep 2021 11:10:00 +0000 (UTC)
Date:   Sun, 5 Sep 2021 12:13:23 +0100
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
        linux-clk@vger.kernel.org
Subject: Re: [PATCH 20/40] mfd: ti_am335x_tscadc: Gather the ctrl register
 logic at one place
Message-ID: <20210905121323.1cfa7dd9@jic23-huawei>
In-Reply-To: <20210902214247.13243c71@xps13>
References: <20210825152518.379386-1-miquel.raynal@bootlin.com>
        <20210825152518.379386-21-miquel.raynal@bootlin.com>
        <20210830145608.09d7e685@jic23-huawei>
        <20210902214247.13243c71@xps13>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 2 Sep 2021 21:42:47 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Jonathan,
> 
> Jonathan Cameron <jic23@kernel.org> wrote on Mon, 30 Aug 2021 14:56:08
> +0100:
> 
> > On Wed, 25 Aug 2021 17:24:58 +0200
> > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> >   
> > > Instead of deriving in the probe and in the resume path the value of the
> > > ctrl register, let's do it only once in the probe, save the value of
> > > this register in the driver's structure and use it from the resume
> > > callback.
> > > 
> > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>    
> > A few minor things inline.
> > 
> > J
> >   
> > > ---
> > >  drivers/mfd/ti_am335x_tscadc.c       | 31 ++++++++--------------------
> > >  include/linux/mfd/ti_am335x_tscadc.h |  2 +-
> > >  2 files changed, 10 insertions(+), 23 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> > > index 7071344ad18e..d661e8ae66c9 100644
> > > --- a/drivers/mfd/ti_am335x_tscadc.c
> > > +++ b/drivers/mfd/ti_am335x_tscadc.c
> > > @@ -122,7 +122,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> > >  	struct clk *clk;
> > >  	u32 val;
> > >  	int tsc_wires = 0, adc_channels = 0, readouts = 0, cell_idx = 0;
> > > -	int total_channels, ctrl, err;
> > > +	int total_channels, err;
> > >  
> > >  	/* Allocate memory for device */
> > >  	tscadc = devm_kzalloc(&pdev->dev, sizeof(*tscadc), GFP_KERNEL);
> > > @@ -215,22 +215,21 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
> > >  	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
> > >  
> > >  	/* Set the control register bits */
> > > -	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
> > > -	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
> > > +	tscadc->ctrl = CNTRLREG_STEPCONFIGWRT | CNTRLREG_STEPID;
> > > +	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);
> > >  
> > >  	if (tsc_wires > 0) {
> > > -		tscadc->tsc_wires = tsc_wires;
> > > +		tscadc->ctrl |= CNTRLREG_TSCENB;
> > >  		if (tsc_wires == 5)
> > > -			ctrl |= CNTRLREG_5WIRE | CNTRLREG_TSCENB;
> > > +			tscadc->ctrl |= CNTRLREG_5WIRE;
> > >  		else
> > > -			ctrl |= CNTRLREG_4WIRE | CNTRLREG_TSCENB;
> > > +			tscadc->ctrl |= CNTRLREG_4WIRE;
> > >  	}
> > >  
> > >  	tscadc_idle_config(tscadc);
> > >  
> > >  	/* Enable the TSC module enable bit */
> > > -	ctrl |= CNTRLREG_TSCSSENB;
> > > -	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
> > > +	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_TSCSSENB);
> > >  
> > >  	/* TSC Cell */
> > >  	if (tsc_wires > 0) {
> > > @@ -305,25 +304,13 @@ static int __maybe_unused tscadc_suspend(struct device *dev)
> > >  static int __maybe_unused tscadc_resume(struct device *dev)
> > >  {
> > >  	struct ti_tscadc_dev *tscadc = dev_get_drvdata(dev);
> > > -	u32 ctrl;
> > >  
> > >  	pm_runtime_get_sync(dev);
> > >  
> > > -	/* context restore */
> > > -	ctrl = CNTRLREG_STEPCONFIGWRT |	CNTRLREG_STEPID;
> > > -	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
> > > -
> > > -	if (tscadc->tsc_wires > 0) {
> > > -		if (tscadc->tsc_wires == 5)
> > > -			ctrl |= CNTRLREG_5WIRE | CNTRLREG_TSCENB;
> > > -		else
> > > -			ctrl |= CNTRLREG_4WIRE | CNTRLREG_TSCENB;
> > > -	}
> > > -	ctrl |= CNTRLREG_TSCSSENB;
> > > -	regmap_write(tscadc->regmap, REG_CTRL, ctrl);
> > > -
> > >  	regmap_write(tscadc->regmap, REG_CLKDIV, tscadc->clk_div);
> > > +	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl);    
> > 
> > Patch description should mention why this ordering change is here.  
> 
> I actually moved the patch that reorders things earlier so that the
> reviewer is not bothered by the order changes later on.
> 
> >   
> > >  	tscadc_idle_config(tscadc);
> > > +	regmap_write(tscadc->regmap, REG_CTRL, tscadc->ctrl | CNTRLREG_TSCSSENB);    
> > 
> > As the value of tscadc->ctrl is not the same as REG_CTRL this is a bit non obvious.
> > 
> > You might be better off keeping them in sync, but masking that bit out and then resetting
> > it as appropriate.  
> 
> I honestly find more readable doing:
> 
> ctrl = flags;
> writel(ctrl);
> writel(ctrl | en_bit);
> 
> than
> 
> ctrl = flags;
> writel(ctrl & ~en_bit);
> writel(ctrl);
> 
> because the second version emphasis the fact that we reset the en_bit
> (which is wrong, the point of this first write is to actually write all
> the configuration but not the en_bit yet) while the first version
> clearly shows that the second write includes an additional "enable bit".

Fair enough.  Perhaps it's worth throwing in a comment though if you happen
to be respining to say tcsadc->ctrl isn't actually the contents of
the register, but rather of 'most' of it.

Jonathan

> 
> Thanks,
> Miquèl

