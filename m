Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE5FAF5F21
	for <lists+linux-iio@lfdr.de>; Sat,  9 Nov 2019 13:38:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfKIMiK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 9 Nov 2019 07:38:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:44636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbfKIMiK (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 9 Nov 2019 07:38:10 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06D64207FF;
        Sat,  9 Nov 2019 12:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573303088;
        bh=XVnSugf5yeS7ju3H3HrhT5xXtiTNx1q/s0jgoUAsGv4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tFShlZ+MHSIVtUdT/SQsfFhOLvjUaLYC7RK2W+lkTkUSFHnZKDgN5BkhXbb4zm/vC
         KlWym7bieROGF/+wAlY0jO6KGCaLezuUph1781ZrIq2YCngy2YHPAcDwFNCXLiyHYq
         GuwZKBAM3s9CwEVBj/yeAmqpx4P9gr8C0O/VW7FU=
Date:   Sat, 9 Nov 2019 12:38:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <robh+dt@kernel.org>, <alexandre.torgue@st.com>,
        <mark.rutland@arm.com>, <mcoquelin.stm32@gmail.com>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: stm32: allow to tune analog clock
Message-ID: <20191109123803.3c002877@archlinux>
In-Reply-To: <20191103123042.54c82559@archlinux>
References: <1572279108-25916-1-git-send-email-fabrice.gasnier@st.com>
        <1572279108-25916-3-git-send-email-fabrice.gasnier@st.com>
        <20191103123042.54c82559@archlinux>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 3 Nov 2019 12:30:42 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 28 Oct 2019 17:11:48 +0100
> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> 
> > Add new optional dt property to tune analog clock prescaler.
> > Driver looks for optional "st,max-clk-rate-hz", then computes
> > best approximation below that rate, using ADC internal prescaler.
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>  
> If the previous email I wrote on this got to anyone before I hit
> cancel, please ignore. Had completely failed to read the code correctly.
> 
> Anyhow this seems fine to me, but given there are a lot of existing
> clk related bindings I'd like to give a little longer for Rob to
> have a chance to take a look at the binding.
> 
> Give me a poke if I seem to have lost this in a week or so.

Applied to the togreg branch of iio.git. Shortly to be pushed out
as testing for the autobuilders to poke at it.

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> 
> 
> > ---
> >  drivers/iio/adc/stm32-adc-core.c | 16 +++++++++++++---
> >  1 file changed, 13 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> > index 20c626c..6537f4f 100644
> > --- a/drivers/iio/adc/stm32-adc-core.c
> > +++ b/drivers/iio/adc/stm32-adc-core.c
> > @@ -79,6 +79,7 @@ struct stm32_adc_priv_cfg {
> >   * @domain:		irq domain reference
> >   * @aclk:		clock reference for the analog circuitry
> >   * @bclk:		bus clock common for all ADCs, depends on part used
> > + * @max_clk_rate:	desired maximum clock rate
> >   * @booster:		booster supply reference
> >   * @vdd:		vdd supply reference
> >   * @vdda:		vdda analog supply reference
> > @@ -95,6 +96,7 @@ struct stm32_adc_priv {
> >  	struct irq_domain		*domain;
> >  	struct clk			*aclk;
> >  	struct clk			*bclk;
> > +	u32				max_clk_rate;
> >  	struct regulator		*booster;
> >  	struct regulator		*vdd;
> >  	struct regulator		*vdda;
> > @@ -141,7 +143,7 @@ static int stm32f4_adc_clk_sel(struct platform_device *pdev,
> >  	}
> >  
> >  	for (i = 0; i < ARRAY_SIZE(stm32f4_pclk_div); i++) {
> > -		if ((rate / stm32f4_pclk_div[i]) <= priv->cfg->max_clk_rate_hz)
> > +		if ((rate / stm32f4_pclk_div[i]) <= priv->max_clk_rate)
> >  			break;
> >  	}
> >  	if (i >= ARRAY_SIZE(stm32f4_pclk_div)) {
> > @@ -230,7 +232,7 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
> >  			if (ckmode)
> >  				continue;
> >  
> > -			if ((rate / div) <= priv->cfg->max_clk_rate_hz)
> > +			if ((rate / div) <= priv->max_clk_rate)
> >  				goto out;
> >  		}
> >  	}
> > @@ -250,7 +252,7 @@ static int stm32h7_adc_clk_sel(struct platform_device *pdev,
> >  		if (!ckmode)
> >  			continue;
> >  
> > -		if ((rate / div) <= priv->cfg->max_clk_rate_hz)
> > +		if ((rate / div) <= priv->max_clk_rate)
> >  			goto out;
> >  	}
> >  
> > @@ -655,6 +657,7 @@ static int stm32_adc_probe(struct platform_device *pdev)
> >  	struct device *dev = &pdev->dev;
> >  	struct device_node *np = pdev->dev.of_node;
> >  	struct resource *res;
> > +	u32 max_rate;
> >  	int ret;
> >  
> >  	if (!pdev->dev.of_node)
> > @@ -731,6 +734,13 @@ static int stm32_adc_probe(struct platform_device *pdev)
> >  	priv->common.vref_mv = ret / 1000;
> >  	dev_dbg(&pdev->dev, "vref+=%dmV\n", priv->common.vref_mv);
> >  
> > +	ret = of_property_read_u32(pdev->dev.of_node, "st,max-clk-rate-hz",
> > +				   &max_rate);
> > +	if (!ret)
> > +		priv->max_clk_rate = min(max_rate, priv->cfg->max_clk_rate_hz);
> > +	else
> > +		priv->max_clk_rate = priv->cfg->max_clk_rate_hz;
> > +
> >  	ret = priv->cfg->clk_sel(pdev, priv);
> >  	if (ret < 0)
> >  		goto err_hw_stop;  
> 

