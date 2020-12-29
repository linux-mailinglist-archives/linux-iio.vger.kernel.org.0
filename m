Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A892E728C
	for <lists+linux-iio@lfdr.de>; Tue, 29 Dec 2020 18:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgL2RP1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 29 Dec 2020 12:15:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgL2RP1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 29 Dec 2020 12:15:27 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F6A021D94;
        Tue, 29 Dec 2020 17:14:44 +0000 (UTC)
Date:   Tue, 29 Dec 2020 17:14:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc:     Xu Wang <vulab@iscas.ac.cn>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <krzk@kernel.org>,
        <andy.shevchenko@gmail.com>, <olivier.moysan@st.com>,
        <etienne.carriere@st.com>, <alexandru.ardelean@analog.com>,
        <peter.ujfalusi@ti.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: stm32-adc: Remove redundant null check before
 clk_prepare_enable/clk_disable_unprepare
Message-ID: <20201229171441.5bfa812b@archlinux>
In-Reply-To: <ccf4d36d-dbb0-aea0-5625-4aaf6850c73d@foss.st.com>
References: <20201218093512.871-1-vulab@iscas.ac.cn>
        <ccf4d36d-dbb0-aea0-5625-4aaf6850c73d@foss.st.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 18 Dec 2020 15:32:32 +0100
Fabrice Gasnier <fabrice.gasnier@foss.st.com> wrote:

> On 12/18/20 10:35 AM, Xu Wang wrote:
> > Because clk_prepare_enable() and clk_disable_unprepare() already checked
> > NULL clock parameter, so the additional checks are unnecessary, just
> > remove them.
> > 
> > Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
> > ---
> >  drivers/iio/adc/stm32-adc-core.c | 29 +++++++++++------------------
> >  drivers/iio/adc/stm32-adc.c      | 14 +++++---------
> >  2 files changed, 16 insertions(+), 27 deletions(-)  
> 
> Hi Xu,
> 
> Acked-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Applied,

thanks,

Jonathan

> 
> Thanks for your patch,
> Best Regards,
> Fabrice
> 
> > 
> > diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> > index 9d1ad6e38e85..c088cb990193 100644
> > --- a/drivers/iio/adc/stm32-adc-core.c
> > +++ b/drivers/iio/adc/stm32-adc-core.c
> > @@ -535,20 +535,16 @@ static int stm32_adc_core_hw_start(struct device *dev)
> >  		goto err_switches_dis;
> >  	}
> >  
> > -	if (priv->bclk) {
> > -		ret = clk_prepare_enable(priv->bclk);
> > -		if (ret < 0) {
> > -			dev_err(dev, "bus clk enable failed\n");
> > -			goto err_regulator_disable;
> > -		}
> > +	ret = clk_prepare_enable(priv->bclk);
> > +	if (ret < 0) {
> > +		dev_err(dev, "bus clk enable failed\n");
> > +		goto err_regulator_disable;
> >  	}
> >  
> > -	if (priv->aclk) {
> > -		ret = clk_prepare_enable(priv->aclk);
> > -		if (ret < 0) {
> > -			dev_err(dev, "adc clk enable failed\n");
> > -			goto err_bclk_disable;
> > -		}
> > +	ret = clk_prepare_enable(priv->aclk);
> > +	if (ret < 0) {
> > +		dev_err(dev, "adc clk enable failed\n");
> > +		goto err_bclk_disable;
> >  	}
> >  
> >  	writel_relaxed(priv->ccr_bak, priv->common.base + priv->cfg->regs->ccr);
> > @@ -556,8 +552,7 @@ static int stm32_adc_core_hw_start(struct device *dev)
> >  	return 0;
> >  
> >  err_bclk_disable:
> > -	if (priv->bclk)
> > -		clk_disable_unprepare(priv->bclk);
> > +	clk_disable_unprepare(priv->bclk);
> >  err_regulator_disable:
> >  	regulator_disable(priv->vref);
> >  err_switches_dis:
> > @@ -575,10 +570,8 @@ static void stm32_adc_core_hw_stop(struct device *dev)
> >  
> >  	/* Backup CCR that may be lost (depends on power state to achieve) */
> >  	priv->ccr_bak = readl_relaxed(priv->common.base + priv->cfg->regs->ccr);
> > -	if (priv->aclk)
> > -		clk_disable_unprepare(priv->aclk);
> > -	if (priv->bclk)
> > -		clk_disable_unprepare(priv->bclk);
> > +	clk_disable_unprepare(priv->aclk);
> > +	clk_disable_unprepare(priv->bclk);
> >  	regulator_disable(priv->vref);
> >  	stm32_adc_core_switches_supply_dis(priv);
> >  	regulator_disable(priv->vdda);
> > diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> > index c067c994dae2..f7c53cea509a 100644
> > --- a/drivers/iio/adc/stm32-adc.c
> > +++ b/drivers/iio/adc/stm32-adc.c
> > @@ -546,8 +546,7 @@ static int stm32_adc_hw_stop(struct device *dev)
> >  	if (adc->cfg->unprepare)
> >  		adc->cfg->unprepare(indio_dev);
> >  
> > -	if (adc->clk)
> > -		clk_disable_unprepare(adc->clk);
> > +	clk_disable_unprepare(adc->clk);
> >  
> >  	return 0;
> >  }
> > @@ -558,11 +557,9 @@ static int stm32_adc_hw_start(struct device *dev)
> >  	struct stm32_adc *adc = iio_priv(indio_dev);
> >  	int ret;
> >  
> > -	if (adc->clk) {
> > -		ret = clk_prepare_enable(adc->clk);
> > -		if (ret)
> > -			return ret;
> > -	}
> > +	ret = clk_prepare_enable(adc->clk);
> > +	if (ret)
> > +		return ret;
> >  
> >  	stm32_adc_set_res(adc);
> >  
> > @@ -575,8 +572,7 @@ static int stm32_adc_hw_start(struct device *dev)
> >  	return 0;
> >  
> >  err_clk_dis:
> > -	if (adc->clk)
> > -		clk_disable_unprepare(adc->clk);
> > +	clk_disable_unprepare(adc->clk);
> >  
> >  	return ret;
> >  }
> >   

