Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54FAF81FAA
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 17:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729096AbfHEPBG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 11:01:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:36196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728848AbfHEPBG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 11:01:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 493A9206C1;
        Mon,  5 Aug 2019 15:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565017264;
        bh=384BdRNrgOOPUHK/Gd5gCMeKsXndGzWgEJedt98ySYI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fPsxLD2kGrZ6nAmuXEvY7FDyBVnBaRN6dt3HrDvCMCeUM86R+p/IRxLYxUESGCwdr
         0GO4aVohZ31gRx359dkq2bXOA9PUhIzUWYsyZ3hj70xgyYYv9UGv/Xfg9YHgFdM/w7
         Ku9eG9Hc8exbAjuMwNOeuhC6dZKBxVsuJSg92C2c=
Date:   Mon, 5 Aug 2019 16:01:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Phil Reid <preid@electromag.com.au>
Cc:     Stephen Boyd <swboyd@chromium.org>, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v6 19/57] iio: Remove dev_err() usage after
 platform_get_irq()
Message-ID: <20190805160100.7f1b92be@archlinux>
In-Reply-To: <6dc9dbc0-c338-eb21-aeb3-70026bebfd41@electromag.com.au>
References: <20190730181557.90391-1-swboyd@chromium.org>
        <20190730181557.90391-20-swboyd@chromium.org>
        <f28e8440-a57d-e269-f3a8-5bf5b9fcd41f@electromag.com.au>
        <5d41a66d.1c69fb81.6d372.4c72@mx.google.com>
        <6dc9dbc0-c338-eb21-aeb3-70026bebfd41@electromag.com.au>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 1 Aug 2019 10:37:40 +0800
Phil Reid <preid@electromag.com.au> wrote:

> G'day Stephen,
> 
> One comment below.

Please send as fresh patch. Nice to clean these up, but I'll loose it
buried in a thread like this!

Thanks,

Jonathan

> 
> On 31/07/2019 22:32, Stephen Boyd wrote:
> > Quoting Phil Reid (2019-07-30 23:42:16)  
> >> G'day Stephen,
> >>
> >> A comment unrelated to your change.
> >>
> >> On 31/07/2019 02:15, Stephen Boyd wrote:
> >> ....
> >>  
> >>> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> >>> index 32f1c4a33b20..abe99856c823 100644
> >>> --- a/drivers/iio/adc/at91_adc.c
> >>> +++ b/drivers/iio/adc/at91_adc.c
> >>> @@ -1179,10 +1179,8 @@ static int at91_adc_probe(struct platform_device *pdev)
> >>>        idev->info = &at91_adc_info;
> >>>    
> >>>        st->irq = platform_get_irq(pdev, 0);
> >>> -     if (st->irq < 0) {
> >>> -             dev_err(&pdev->dev, "No IRQ ID is designated\n");
> >>> +     if (st->irq < 0)
> >>>                return -ENODEV;  
> >> Should this be returning st->irq instead of -ENODEV?
> >> eg: platform_get_irq can return -EPROBE_DEFER
> >>
> >> Pattern is repeated in a number of other places.  
> > 
> > Probably? Here's a patch.
> > 
> > ----8<----
> > From: Stephen Boyd <swboyd@chromium.org>
> > Subject: [PATCH] iio: Return error values from platform_get_irq*()
> > 
> > Sometimes platform_get_irq*() can return -EPROBE_DEFER, so it's best to
> > return the actual error value from calling this function instead of
> > overriding the value to something like -EINVAL or -ENXIO. Except for in
> > the case when the irq value is 0 and the driver knows that irq 0 isn't
> > valid. In such a situation, return whatever error value was returned
> > before this change.
> > 
> > Reported-by: Phil Reid <preid@electromag.com.au>
> > Cc: Phil Reid <preid@electromag.com.au>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Hartmut Knaack <knaack.h@gmx.de>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> > Cc: linux-iio@vger.kernel.org
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >   drivers/iio/adc/at91_adc.c      | 2 +-
> >   drivers/iio/adc/bcm_iproc_adc.c | 2 +-
> >   drivers/iio/adc/fsl-imx25-gcq.c | 4 +---
> >   drivers/iio/adc/lpc32xx_adc.c   | 2 +-
> >   drivers/iio/adc/npcm_adc.c      | 2 +-
> >   drivers/iio/adc/spear_adc.c     | 2 +-
> >   6 files changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> > index abe99856c823..2c604198c4b7 100644
> > --- a/drivers/iio/adc/at91_adc.c
> > +++ b/drivers/iio/adc/at91_adc.c
> > @@ -1180,7 +1180,7 @@ static int at91_adc_probe(struct platform_device *pdev)
> >   
> >   	st->irq = platform_get_irq(pdev, 0);
> >   	if (st->irq < 0)
> > -		return -ENODEV;
> > +		return st->irq;
> >   
> >   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >   
> > diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
> > index 646ebdc0a8b4..6c05ea510c40 100644
> > --- a/drivers/iio/adc/bcm_iproc_adc.c
> > +++ b/drivers/iio/adc/bcm_iproc_adc.c
> > @@ -541,7 +541,7 @@ static int iproc_adc_probe(struct platform_device *pdev)
> >   
> >   	adc_priv->irqno = platform_get_irq(pdev, 0);
> >   	if (adc_priv->irqno <= 0)
> > -		return -ENODEV;
> > +		return adc_priv->irqno;  
> 
> 		return adc_priv->irqno ? : -ENODEV;
> 
> >   
> >   	ret = regmap_update_bits(adc_priv->regmap, IPROC_REGCTL2,
> >   				IPROC_ADC_AUXIN_SCAN_ENA, 0);
> > diff --git a/drivers/iio/adc/fsl-imx25-gcq.c b/drivers/iio/adc/fsl-imx25-gcq.c
> > index fa71489195c6..ee20ab09abe5 100644
> > --- a/drivers/iio/adc/fsl-imx25-gcq.c
> > +++ b/drivers/iio/adc/fsl-imx25-gcq.c
> > @@ -340,9 +340,7 @@ static int mx25_gcq_probe(struct platform_device *pdev)
> >   
> >   	priv->irq = platform_get_irq(pdev, 0);
> >   	if (priv->irq <= 0) {
> > -		ret = priv->irq;
> > -		if (!ret)
> > -			ret = -ENXIO;
> > +		ret = priv->irq ? : -ENXIO;
> >   		goto err_clk_unprepare;
> >   	}
> >   
> > diff --git a/drivers/iio/adc/lpc32xx_adc.c b/drivers/iio/adc/lpc32xx_adc.c
> > index b896f7ff4572..edbb58212fba 100644
> > --- a/drivers/iio/adc/lpc32xx_adc.c
> > +++ b/drivers/iio/adc/lpc32xx_adc.c
> > @@ -173,7 +173,7 @@ static int lpc32xx_adc_probe(struct platform_device *pdev)
> >   
> >   	irq = platform_get_irq(pdev, 0);
> >   	if (irq <= 0)
> > -		return -ENXIO;
> > +		return irq ? : -ENXIO;
> >   
> >   	retval = devm_request_irq(&pdev->dev, irq, lpc32xx_adc_isr, 0,
> >   				  LPC32XXAD_NAME, st);
> > diff --git a/drivers/iio/adc/npcm_adc.c b/drivers/iio/adc/npcm_adc.c
> > index 910f3585fa54..1e54a64a4534 100644
> > --- a/drivers/iio/adc/npcm_adc.c
> > +++ b/drivers/iio/adc/npcm_adc.c
> > @@ -225,7 +225,7 @@ static int npcm_adc_probe(struct platform_device *pdev)
> >   
> >   	irq = platform_get_irq(pdev, 0);
> >   	if (irq <= 0) {
> > -		ret = -EINVAL;
> > +		ret = irq ? : -EINVAL;
> >   		goto err_disable_clk;
> >   	}
> >   
> > diff --git a/drivers/iio/adc/spear_adc.c b/drivers/iio/adc/spear_adc.c
> > index 592b97c464da..9b16717ac7e7 100644
> > --- a/drivers/iio/adc/spear_adc.c
> > +++ b/drivers/iio/adc/spear_adc.c
> > @@ -301,7 +301,7 @@ static int spear_adc_probe(struct platform_device *pdev)
> >   
> >   	irq = platform_get_irq(pdev, 0);
> >   	if (irq <= 0) {
> > -		ret = -EINVAL;
> > +		ret = irq ? : -EINVAL;
> >   		goto errout2;
> >   	}
> >   
> >   
> 
> 

