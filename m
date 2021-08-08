Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1CA3E3BF2
	for <lists+linux-iio@lfdr.de>; Sun,  8 Aug 2021 19:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhHHRaR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Aug 2021 13:30:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:57808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230448AbhHHRaQ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 8 Aug 2021 13:30:16 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 075EE60EE9;
        Sun,  8 Aug 2021 17:29:53 +0000 (UTC)
Date:   Sun, 8 Aug 2021 18:32:43 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Yizhuo <yzhai003@ucr.edu>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Olivier Moysan <olivier.moysan@st.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: Fix the uninitialized use if
 regmap_read() fails
Message-ID: <20210808183243.70619aa8@jic23-huawei>
In-Reply-To: <20210724164840.7381053b@jic23-huawei>
References: <20210719195313.40341-1-yzhai003@ucr.edu>
        <20210724164840.7381053b@jic23-huawei>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 24 Jul 2021 16:48:40 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 19 Jul 2021 19:53:11 +0000
> Yizhuo <yzhai003@ucr.edu> wrote:
> 
> > Inside function stm32_dfsdm_irq(), the variable "status", "int_en"
> > could be uninitialized if the regmap_read() fails and returns an error
> > code.  However, they are directly used in the later context to decide
> > the control flow, which is potentially unsafe.
> > 
> > Fixes: e2e6771c64625 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")
> > 
> > Signed-off-by: Yizhuo <yzhai003@ucr.edu>  
> 
> Hi Yizhou
> 
> I want to get some review of this from people familiar with the
> hardware as there is a small possibility your reordering might have
> introduced a problem.

To stm32 people, can someone take a look at this?

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/adc/stm32-dfsdm-adc.c | 9 +++++++--
> >  1 file changed, 7 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> > index 1cfefb3b5e56..d8b78aead942 100644
> > --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> > +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> > @@ -1292,9 +1292,11 @@ static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
> >  	struct stm32_dfsdm_adc *adc = iio_priv(indio_dev);
> >  	struct regmap *regmap = adc->dfsdm->regmap;
> >  	unsigned int status, int_en;
> > +	int ret;
> >  
> > -	regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
> > -	regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);  
> 
> Moving this later is only valid if there aren't any side effects.
> The current ordering is strange enough it makes me wonder if there might be!
> 
> Jonathan
> 
> > +	ret = regmap_read(regmap, DFSDM_ISR(adc->fl_id), &status);
> > +	if (ret)
> > +		return IRQ_HANDLED;
> >  
> >  	if (status & DFSDM_ISR_REOCF_MASK) {
> >  		/* Read the data register clean the IRQ status */
> > @@ -1303,6 +1305,9 @@ static irqreturn_t stm32_dfsdm_irq(int irq, void *arg)
> >  	}
> >  
> >  	if (status & DFSDM_ISR_ROVRF_MASK) {
> > +		ret = regmap_read(regmap, DFSDM_CR2(adc->fl_id), &int_en);
> > +		if (ret)
> > +			return IRQ_HANDLED;
> >  		if (int_en & DFSDM_CR2_ROVRIE_MASK)
> >  			dev_warn(&indio_dev->dev, "Overrun detected\n");
> >  		regmap_update_bits(regmap, DFSDM_ICR(adc->fl_id),  
> 

